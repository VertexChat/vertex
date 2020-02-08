DROP DATABASE IF EXISTS vertex_db;
create database vertex_db default CHARACTER SET = utf8 default COLLATE = utf8_general_ci;
use vertex_db;

CREATE TABLE user
(
    user_id INTEGER(4) unsigned NOT NULL auto_increment,
    user_name VARCHAR(32) NOT NULL,
    password VARCHAR(255) NOT NULL,
    display_name VARCHAR(32) NOT NULL,

    PRIMARY KEY(user_id),
    UNIQUE KEY (user_name)
) ENGINE = INNODB;

CREATE TABLE channel
(
    channel_id INTEGER(4) unsigned NOT NULL auto_increment,
    channel_name VARCHAR(32) NOT NULL,
    user_id INTEGER(4) unsigned NOT NULL,
    channel_capacity INTEGER(4) NOT NULL,
    channel_type ENUM ('TEXT', 'VOICE', 'DM') NOT NULL,
    channel_position INTEGER(4) NOT NULL,

    PRIMARY KEY(channel_id),
    FOREIGN KEY(user_id) REFERENCES user(user_id)
) ENGINE = INNODB;

CREATE TABLE message
(
    message_id INTEGER(4) unsigned NOT NULL auto_increment,
    channel_id INTEGER(4) unsigned NOT NULL,
    user_id INTEGER(4) unsigned NOT NULL,
    message_content VARCHAR(255) NOT NULL,
    message_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    edited_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY(message_id),
    FOREIGN KEY(channel_id) REFERENCES channel(channel_id),
    FOREIGN KEY(user_id) REFERENCES user(user_id)
) ENGINE = INNODB;

CREATE TABLE attatchment
(
    attatchment_id INTEGER(4) unsigned NOT NULL auto_increment,
    file_name VARCHAR(32) NOT NULL,
    message_id INTEGER(4) unsigned NOT NULL,
    file_size INTEGER(64) NOT NULL,
    file_url VARCHAR(255) NOT NULL,

    PRIMARY KEY (attatchment_id),
    FOREIGN KEY(message_id) REFERENCES message(message_id)  
) ENGINE = INNODB;

/* Create user */
select * from user;
insert into user(user_name, password, display_name)
    values ('mreilly', 'foo1bar2', 'mreilly');
insert into user(user_name, password, display_name)
    values ('cbutler', 'foo1bar2', 'cbutler');
insert into user(user_name, password, display_name)
    values ('dneilan', 'foo1bar2', 'dneilan');
insert into user(user_name, password, display_name)
    values ('user1', 'foo1bar2', 'exampleUser');
select * from user;

/* Update user */
select * from user;
update user set user_name = 'morganreilly' where user_id = 1;
update user set password = 'aFc334bb4hsg3' where user_id = 1;
update user set display_name = 'annie-hash' where user_id = 1;
select * from user;

/* Delete user */
select * from user;
delete from user where user_id = 4;
select * from user;

/* Read user by id */
select * from user where user_id = 2;

/* Create channel input */
select * from channel;
insert into channel(channel_name, user_id, channel_capacity, channel_type, channel_position)
    values ('Development', 0001, 20, 'TEXT', 1);
insert into channel(channel_name, user_id, channel_capacity, channel_type, channel_position)
    values ('Development', 0002, 20, 'TEXT', 1);
insert into channel(channel_name, user_id, channel_capacity, channel_type, channel_position)
    values ('Development', 3, 20, 'TEXT', 1);

insert into channel(channel_name, user_id, channel_capacity, channel_type, channel_position)
    values ('Gaming', 1, 20, 'VOICE', 1);
insert into channel(channel_name, user_id, channel_capacity, channel_type, channel_position)
    values ('Gaming', 2, 20, 'VOICE', 1);
insert into channel(channel_name, user_id, channel_capacity, channel_type, channel_position)
    values ('Gaming', 3, 20, 'VOICE', 1);
select * from channel;

/* Create message input */
select * from message;
insert into message(channel_id, user_id, message_content) 
    values (3, 1, 'Hello, world');
insert into message(channel_id, user_id, message_content) 
    values (3, 2, 'Hello, world');
insert into message(channel_id, user_id, message_content) 
    values (1, 3, 'Hello, world');
select * from message;


/* Create attatchment input 
Note -- This probably may change to allow for file inputs
*/
select * from attatchment;
insert into attatchment(file_name, message_id, file_size, file_url)
    values ('Example_file.jpg', 3, 1064, './home/pictures');
insert into attatchment(file_name, message_id, file_size, file_url)
    values ('Example_file2.jpg', 6, 10641064, './home/pictures');
insert into attatchment(file_name, message_id, file_size, file_url)
    values ('Example_file2.jpg', 1, 10641064, './home/pictures');
select * from attatchment;

/* Case 1:
Display user name, display name, associated channels and types for all users
*/
select usr.user_name, usr.display_name, chnl.channel_name, chnl.channel_type from user usr inner join channel chnl on usr.user_id = chnl.user_id;  

/* Case 1.1:
Display user name, display name, associated voice channels and types for all users
*/
select usr.user_name, usr.display_name, chnl.channel_name, chnl.channel_type from user usr inner join channel chnl on usr.user_id = chnl.user_id where chnl.channel_type = 'VOICE';  

/* Case 1.2:
Display user name, display name, associated channels for specific user
*/
select usr.user_name, usr.display_name, chnl.channel_name, chnl.channel_type from user usr inner join channel chnl on usr.user_id = chnl.user_id where usr.user_id = 1;  

/* Case 2.1:
Display all messages by all users by display name along with time sent for a all channels
*/
select usr.display_name, chnl.channel_name, chnl.channel_type, msg.message_content, msg.message_timestamp from user usr inner join channel chnl on usr.user_id = chnl.user_id inner join message msg on chnl.user_id = msg.user_id;

/* Case 2.2:
Display all messages for specific user by display name along with time sent for a all channels
*/
select usr.display_name, chnl.channel_name, msg.message_content, msg.message_timestamp from user usr inner join channel chnl on usr.user_id = chnl.user_id inner join message msg on chnl.user_id = msg.user_id where usr.user_id = 1;

/* Case 2.3:
Display all messages for specific user by display name along with time sent for a specific channel
*/
select usr.display_name, chnl.channel_name, msg.message_content, msg.message_timestamp from user usr inner join channel chnl on usr.user_id = chnl.user_id inner join message msg on chnl.user_id = msg.user_id where usr.user_id = 1 and chnl.channel_name = 'Development';

/* Case 3:
Display all files sent by all users in all channels
*/
select usr.user_name, chnl.channel_name, att.file_name from user usr inner join channel chnl on usr.user_id = chnl.user_id inner join message msg on chnl.user_id = msg.user_id inner join attatchment att on msg.message_id = att.message_id;

/* Case 3.1:
Display all files sent by specific user in all channels
*/
select usr.user_name, chnl.channel_name, att.file_name from user usr inner join channel chnl on usr.user_id = chnl.user_id inner join message msg on chnl.user_id = msg.user_id inner join attatchment att on msg.message_id = att.message_id where usr.user_id = 1;
