DROP DATABASE IF EXISTS vertex_db;
create database vertex_db default CHARACTER SET = utf8 default COLLATE = utf8_general_ci;
use vertex_db;

CREATE TABLE user
(
    user_id INTEGER(4) unsigned zerofill NOT NULL auto_increment,
    user_name VARCHAR(32) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    password_salt VARCHAR(255) NOT NULL,
    display_name VARCHAR(32) NOT NULL,

    PRIMARY KEY(user_id),
    UNIQUE KEY (user_name)
) ENGINE = INNODB;

CREATE TABLE channel
(
    channel_id INTEGER(4) unsigned zerofill NOT NULL auto_increment,
    channel_name VARCHAR(32) NOT NULL,
    user_id INTEGER(4) unsigned zerofill NOT NULL,
    channel_capacity INTEGER(4) NOT NULL,
    channel_type ENUM ('TEXT', 'VOICE', 'DM') NOT NULL,
    channel_position INTEGER(4) NOT NULL,

    PRIMARY KEY(channel_id),
    FOREIGN KEY(user_id) REFERENCES user(user_id)
) ENGINE = INNODB;

CREATE TABLE message
(
    message_id INTEGER(4) unsigned zerofill NOT NULL auto_increment,
    channel_id INTEGER(4) unsigned zerofill NOT NULL,
    user_id INTEGER(4) unsigned zerofill NOT NULL,
    message_content VARCHAR(255) NOT NULL,
    message_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    edited_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY(message_id),
    FOREIGN KEY(channel_id) REFERENCES channel(channel_id),
    FOREIGN KEY(user_id) REFERENCES user(user_id)
) ENGINE = INNODB;

CREATE TABLE attatchment
(
    attatchment_id INTEGER(4) unsigned zerofill NOT NULL auto_increment,
    file_name VARCHAR(32) NOT NULL,
    message_id INTEGER(4) unsigned zerofill NOT NULL,
    file_size INTEGER(64) NOT NULL,
    file_url VARCHAR(255) NOT NULL,

    PRIMARY KEY (attatchment_0id  
)


/* Testing user input */
select * from user;
insert into user(user_name, password_hash, password_salt, display_name)
    values ('mreilly', 'foo1', 'bar2', 'mreilly');
insert into user(user_name, password_hash, password_salt, display_name)
    values ('cbutler', 'foo1', 'bar2', 'cbutler');
insert into user(user_name, password_hash, password_salt, display_name)
    values ('dneilan', 'foo1', 'bar2', 'dneilan');
select * from user;

/* Testing channel input */
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

/* Testing message input */
select * from message;
insert into message(channel_id, user_id, message_content) 
    values (3, 1, 'Hello, word');
insert into message(channel_id, user_id, message_content) 
    values (3, 2, 'Hello, word');
insert into message(channel_id, user_id, message_content) 
    values (1, 3, 'Hello, word');
select * from message;
