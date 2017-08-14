drop database if exists sso;

create database if not exists sso;

use sso;

drop table if exists users;

create table if not exists users (
  username varchar(255),
  password varchar(255),
  enabled  boolean
);

drop table if exists authorities;

create table if not exists authorities (
  username  varchar(255),
  authority varchar(255)
);

drop table if exists oauth_client_details;

create table if not exists oauth_client_details (
  client_id               varchar(255) primary key,
  resource_ids            varchar(255),
  client_secret           varchar(255),
  scope                   varchar(255),
  authorized_grant_types  varchar(255),
  web_server_redirect_uri varchar(255),
  authorities             varchar(255),
  access_token_validity   integer,
  refresh_token_validity  integer,
  additional_information  varchar(4096),
  autoapprove             varchar(255)
);

drop table if exists oauth_client_token;

create table if not exists oauth_client_token (
  token_id          varchar(255),
  token             varbinary(4096),
  authentication_id varchar(255),
  user_name         varchar(255),
  client_id         varchar(255)
);
drop table if exists oauth_access_token;

create table if not exists oauth_access_token (
  token_id          varchar(255),
  token             varbinary(4096),
  authentication_id varchar(255),
  user_name         varchar(255),
  client_id         varchar(255),
  authentication    varbinary(4096),
  refresh_token     varchar(255)
);

drop table if exists oauth_refresh_token;

create table if not exists oauth_refresh_token (
  token_id       varchar(255),
  token          varbinary(4096),
  authentication varbinary(4096)
);

drop table if exists oauth_code;

create table if not exists oauth_code (
  code           varchar(255),
  authentication varbinary(4096)
);

# 用户
insert into users values ('user', 'user', true);
insert into users values ('admin', 'admin', true);

# 权限
insert into authorities values ('user', 'ROLE_USER');
insert into authorities values ('admin', 'ROLE_ADMIN');

# 客户端信息
insert into oauth_client_details (client_id, resource_ids, scope, authorized_grant_types, authorities, access_token_validity)
values ('my-trusted-client', 'oauth2-resource', 'read,write,trust', 'password,authorization_code,refresh_token,implicit', 'ROLE_CLIENT,ROLE_TRUSTED_CLIENT', 60);

insert into oauth_client_details (client_id, resource_ids, scope, authorized_grant_types, authorities, web_server_redirect_uri)
values ('my-client-with-registered-redirect', 'oauth2-resource', 'read,trust', 'authorization_code', 'ROLE_CLIENT', 'http://anywhere?key=value');

insert into oauth_client_details (client_id, client_secret, resource_ids, scope, authorized_grant_types, authorities)
values ('my-client-with-secret', 'secret', 'oauth2-resource', 'read', 'password,client_credentials', 'ROLE_CLIENT');

insert into oauth_client_details(client_id, client_secret, scope, authorized_grant_types, authorities, access_token_validity, refresh_token_validity)
values ('301575942','wangyiyunyinyue', 'read,write','authorization_code,password,client_credentials,implicit,refresh_token', 'ROLE_CLIENT',60, 120)
