CREATE SCHEMA IF NOT EXISTS "public";

CREATE SEQUENCE "public".rol_id_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".user_id_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE  TABLE "public".brands ( 
	id_brand             integer  NOT NULL  ,
	brand                varchar(100)  NOT NULL  ,
	created_date         date DEFAULT CURRENT_DATE   ,
	updated_date         date DEFAULT CURRENT_DATE   ,
	is_active            boolean DEFAULT true NOT NULL  ,
	CONSTRAINT pk_brands PRIMARY KEY ( id_brand )
 );

CREATE  TABLE "public".charges ( 
	code                 varchar(100)    ,
	name                 varchar(100)    ,
	created_date         date DEFAULT CURRENT_DATE NOT NULL  ,
	updated_date         date    ,
	is_active            boolean DEFAULT true NOT NULL  ,
	id_charge            integer  NOT NULL  ,
	CONSTRAINT pk_charges PRIMARY KEY ( id_charge )
 );

CREATE  TABLE "public".customers ( 
	id_customer          integer  NOT NULL  ,
	name                 varchar(50)  NOT NULL  ,
	lastname             varchar(50)  NOT NULL  ,
	identify             varchar(8)  NOT NULL  ,
	phone                varchar(11)  NOT NULL  ,
	phone1               varchar(11)    ,
	is_active            boolean DEFAULT true NOT NULL  ,
	created_date         date DEFAULT CURRENT_DATE NOT NULL  ,
	updated_date         date DEFAULT CURRENT_DATE   ,
	nationality          varchar DEFAULT 'V'::character varying NOT NULL  ,
	CONSTRAINT pk_customers PRIMARY KEY ( id_customer )
 );

CREATE  TABLE "public".inches ( 
	id_inch              integer  NOT NULL  ,
	inch                 integer  NOT NULL  ,
	created_date         date DEFAULT CURRENT_DATE NOT NULL  ,
	updated_date         date    ,
	is_active            boolean DEFAULT true NOT NULL  ,
	CONSTRAINT pk_inches PRIMARY KEY ( id_inch )
 );

CREATE  TABLE "public".rol ( 
	id                   serial  NOT NULL  ,
	name                 varchar(20)  NOT NULL  ,
	created_date         date DEFAULT CURRENT_DATE NOT NULL  ,
	updated_date         date    ,
	is_active            boolean DEFAULT true NOT NULL  ,
	CONSTRAINT "PK_c93a22388638fac311781c7f2dd" PRIMARY KEY ( id )
 );

CREATE  TABLE "public"."user" ( 
	id                   serial  NOT NULL  ,
	username             varchar(20)  NOT NULL  ,
	email                varchar  NOT NULL  ,
	nationality          varchar(1)  NOT NULL  ,
	identify             integer  NOT NULL  ,
	"password"           varchar  NOT NULL  ,
	name_lastname        varchar  NOT NULL  ,
	created_date         timestamp DEFAULT now() NOT NULL  ,
	updated_date         timestamp DEFAULT now()   ,
	last_login           timestamp    ,
	is_staff             boolean DEFAULT false NOT NULL  ,
	is_active            boolean DEFAULT true NOT NULL  ,
	is_superuser         boolean DEFAULT false NOT NULL  ,
	"rolId"              integer    ,
	CONSTRAINT "PK_cace4a159ff9f2512dd42373760" PRIMARY KEY ( id ),
	CONSTRAINT "UQ_78a916df40e02a9deb1c4b75edb" UNIQUE ( username ) ,
	CONSTRAINT "UQ_e12875dfb3b1d92d7d7c5377e22" UNIQUE ( email ) ,
	CONSTRAINT "UQ_fbdf6a2e984ba8d5a60e8d00df4" UNIQUE ( identify ) ,
	CONSTRAINT "FK_f66058a8f024b32ce70e0d6a929" FOREIGN KEY ( "rolId" ) REFERENCES "public".rol( id )   
 );

CREATE  TABLE "public".workers ( 
	id_worker            integer  NOT NULL  ,
	name                 varchar(100)  NOT NULL  ,
	lastname             varchar(100)  NOT NULL  ,
	identify             varchar(8)  NOT NULL  ,
	id1_charge           integer  NOT NULL  ,
	created_date         date DEFAULT CURRENT_DATE NOT NULL  ,
	updated_date         date    ,
	is_active            boolean DEFAULT true NOT NULL  ,
	nationality          varchar DEFAULT 'v'::character varying NOT NULL  ,
	CONSTRAINT pk_workers PRIMARY KEY ( id_worker ),
	CONSTRAINT fk_workers_charges FOREIGN KEY ( id1_charge ) REFERENCES "public".charges( id_charge )   
 );

CREATE INDEX idx_workers_0 ON "public".workers USING  btree ( id1_charge );

CREATE  TABLE "public".gadgets ( 
	id_gadget            integer  NOT NULL  ,
	name                 varchar(100)  NOT NULL  ,
	description          text    ,
	entry_date           date DEFAULT CURRENT_DATE NOT NULL  ,
	repaired             boolean DEFAULT false NOT NULL  ,
	budget               bigint DEFAULT 0 NOT NULL  ,
	paid                 boolean DEFAULT false NOT NULL  ,
	payment_date         date    ,
	departure_date       date    ,
	"return"             boolean DEFAULT false NOT NULL  ,
	is_active            boolean DEFAULT true NOT NULL  ,
	created_date         date DEFAULT CURRENT_DATE   ,
	updated_date         date    ,
	id1_brand            integer  NOT NULL  ,
	id1_inch             integer  NOT NULL  ,
	id1_customer         integer  NOT NULL  ,
	id1_worker           integer  NOT NULL  ,
	CONSTRAINT pk_gadgets PRIMARY KEY ( id_gadget ),
	CONSTRAINT idx_gadgets UNIQUE ( id1_brand ) ,
	CONSTRAINT idx_gadgets_0 UNIQUE ( id1_inch ) ,
	CONSTRAINT fk_gadgets_customers FOREIGN KEY ( id1_customer ) REFERENCES "public".customers( id_customer )   ,
	CONSTRAINT fk_gadgets_workers FOREIGN KEY ( id1_worker ) REFERENCES "public".workers( id_worker )   ,
	CONSTRAINT fk_gadgets_brands FOREIGN KEY ( id1_brand ) REFERENCES "public".brands( id_brand )   ,
	CONSTRAINT fk_gadgets_inches FOREIGN KEY ( id1_inch ) REFERENCES "public".inches( id_inch )   
 );

CREATE INDEX idx_gadgets_1 ON "public".gadgets USING  btree ( id1_customer );

CREATE INDEX idx_gadgets_2 ON "public".gadgets USING  btree ( id1_worker );

INSERT INTO "public".brands( id_brand, brand, created_date, updated_date, is_active ) VALUES ( 1, 'Daewoo', '2024-08-01', '2024-08-01', true);
INSERT INTO "public".brands( id_brand, brand, created_date, updated_date, is_active ) VALUES ( 2, 'Toshiba', '2024-08-01', '2024-08-01', true);
INSERT INTO "public".brands( id_brand, brand, created_date, updated_date, is_active ) VALUES ( 3, 'Sony', '2024-08-01', '2024-08-01', true);
INSERT INTO "public".charges( code, name, created_date, updated_date, is_active, id_charge ) VALUES ( 'C001', 'Electrónico I', '2024-08-01', null, true, 1);
INSERT INTO "public".charges( code, name, created_date, updated_date, is_active, id_charge ) VALUES ( 'C002', 'Electrónico II', '2024-08-01', null, true, 2);
INSERT INTO "public".charges( code, name, created_date, updated_date, is_active, id_charge ) VALUES ( 'C003', 'Electrónico III', '2024-08-01', null, true, 3);
INSERT INTO "public".charges( code, name, created_date, updated_date, is_active, id_charge ) VALUES ( 'C004', 'Electrónico IV', '2024-08-01', null, true, 4);
INSERT INTO "public".charges( code, name, created_date, updated_date, is_active, id_charge ) VALUES ( 'C005', 'Electrónico V', '2024-08-01', null, true, 5);
INSERT INTO "public".inches( id_inch, inch, created_date, updated_date, is_active ) VALUES ( 1, 21, '2024-08-01', null, true);
INSERT INTO "public".inches( id_inch, inch, created_date, updated_date, is_active ) VALUES ( 2, 27, '2024-08-01', null, true);
INSERT INTO "public".inches( id_inch, inch, created_date, updated_date, is_active ) VALUES ( 3, 32, '2024-08-01', null, true);
INSERT INTO "public".rol( id, name, created_date, updated_date, is_active ) VALUES ( 1, 'Administrador', '2024-08-01', null, true);
INSERT INTO "public".rol( id, name, created_date, updated_date, is_active ) VALUES ( 2, 'Usuario', '2024-08-01', null, true);
INSERT INTO "public"."user"( id, username, email, nationality, identify, "password", name_lastname, created_date, updated_date, last_login, is_staff, is_active, is_superuser, "rolId" ) VALUES ( 1, 'Esteban23', 'esteban@gmail.com', 'V', 27498161, '1234', 'Esteban Alayon', '2024-08-01 04:27:26 a. m.', '2024-08-01 04:27:26 a. m.', null, true, true, true, null);
INSERT INTO "public".workers( id_worker, name, lastname, identify, id1_charge, created_date, updated_date, is_active, nationality ) VALUES ( 1, 'Sandy', 'Alayón', '27498161', 1, '2024-08-01', null, true, 'V');