DROP TABLE IF EXISTS users, spaces, requests;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name text,
  email varchar(319),
  password text,
  loggedin text DEFAULT 'true'
);

CREATE TABLE spaces (
  id SERIAL PRIMARY KEY,
  name text,
  description text,
  price_per_night int,
  available_dates text,
  image_link text,
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);

CREATE TABLE requests (
  id SERIAL PRIMARY KEY,
  approved text,
  requested_date text,
  user_id integer REFERENCES users ON DELETE CASCADE,
  space_id integer REFERENCES spaces ON DELETE CASCADE
);

TRUNCATE TABLE users, spaces, requests RESTART IDENTITY;
INSERT INTO users (name, email, password, loggedin) VALUES ('Ruby', 'ruby1@gmail.com', '12345', 'true');
INSERT INTO users (name, email, password, loggedin) VALUES ('Joe', 'joe@gmail.com', '5678', 'false');
INSERT INTO users (name, email, password, loggedin) VALUES ('Peter', 'peter@gmail.com', '5678', 'true');

INSERT INTO spaces (name, description, price_per_night, available_dates, image_link, user_id) VALUES ('The Coza, Joshua Tree', 'The Coza, Joshua Tree is a special resort-style vacation retreat and newly build in July 2022.', 145, '11/10/2022,12/10/2022,13/10/2022', 'https://mldvwwasb8tu.i.optimole.com/cb:esbD~6200b/w:1536/h:1152/q:mauto/https://travelaway.me/wp-content/uploads/2020/04/whisper-rock-ranch.jpg', 1);
INSERT INTO spaces (name, description, price_per_night, available_dates, image_link, user_id) VALUES ('Bamburgh Village - Captains Landing', 'Beautifully appointed 2 bed apartment located at West House in the sought after village of Bamburgh.', 123, '15/10/2022,16/10/2022,17/10/2022', 'https://uploads-ssl.webflow.com/576fd5a8f192527e50a4b95c/60280544cb6d8d59477ebdfe_Lighthouse%20cottage%20Scotland.jpg', 2);

INSERT INTO requests (approved, requested_date, user_id, space_id) VALUES ('true', '16/10/2022', 1, 2);
INSERT INTO requests (approved, requested_date, user_id, space_id) VALUES ('false', '11/10/2022', 3, 1);
INSERT INTO requests (approved, requested_date, user_id, space_id) VALUES ('false', '13/10/2022', 2, 1);