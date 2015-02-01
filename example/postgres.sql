DROP TABLE IF EXISTS example_payment;
DROP TABLE IF EXISTS example_invoice;
DROP TABLE IF EXISTS example_user;
DROP TABLE IF EXISTS example_user_state_lookup;
DROP TABLE IF EXISTS example_invoice_state_lookup;

CREATE TABLE example_user_state_lookup (
	id integer NOT NULL UNIQUE,
	name varchar(32) NOT NULL
);

CREATE UNIQUE INDEX example_user_state_lookup_name_idx ON example_user_state_lookup(name);

INSERT INTO example_user_state_lookup(id, name) VALUES(1, 'pending');
INSERT INTO example_user_state_lookup(id, name) VALUES(2, 'active');
INSERT INTO example_user_state_lookup(id, name) VALUES(3, 'suspended');
INSERT INTO example_user_state_lookup(id, name) VALUES(4, 'closed');

CREATE TABLE example_invoice_state_lookup (
	id integer NOT NULL UNIQUE,
        state varchar(32) NOT NULL
);

CREATE UNIQUE INDEX example_invoice_state_lookup_name_idx ON example_invoice_state_lookup(state);

INSERT INTO example_invoice_state_lookup(id, state) VALUES(1, 'paid');
INSERT INTO example_invoice_state_lookup(id, state) VALUES(2, 'failed');
INSERT INTO example_invoice_state_lookup(id, state) VALUES(3, 'pending');

CREATE TABLE example_user (
	id serial primary key NOT NULL,
	username varchar(254) NOT NULL,
	password varchar(254) NOT NULL,
	email_address text NOT NULL,
	created timestamp NOT NULL DEFAULT current_timestamp,
	state integer NOT NULL DEFAULT 1,

	FOREIGN KEY(state) REFERENCES example_user_state_lookup(id)
);

CREATE UNIQUE INDEX example_user_username_idx ON example_user(username);

CREATE TABLE example_invoice (
	id serial primary key NOT NULL,
        amount numeric(10,2) NOT NULL,
	user_id integer NOT NULL,
	payer_id integer NULL,
	state integer NOT NULL DEFAULT 3,
	created timestamp NOT NULL DEFAULT current_timestamp,
	processed timestamp NULL,

	FOREIGN KEY(user_id) REFERENCES example_user(id),
	FOREIGN KEY(payer_id) REFERENCES example_user(id),
	FOREIGN KEY(state) REFERENCES example_invoice_state_lookup(id)
);

CREATE TABLE example_payment (
        id serial primary key NOT NULL,
        amount numeric(10,2) NOT NULL,
	invoice_id integer NOT NULL,
        created timestamp NOT NULL DEFAULT current_timestamp,

        FOREIGN KEY(invoice_id) REFERENCES example_invoice(id)
);

CREATE UNIQUE INDEX example_payment_user_id_idx ON example_payment(invoice_id);

GRANT ALL ON example_payment,example_payment_id_seq,example_user,example_user_id_seq,example_user_state_lookup,example_invoice_state_lookup,example_invoice,example_invoice_id_seq TO example;
