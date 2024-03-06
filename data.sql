\c biztime

DROP TABLE IF EXISTS invoices;
DROP TABLE IF EXISTS companies;
DROP TABLE IF EXISTS industries;

CREATE TABLE companies (
    code text PRIMARY KEY,
    name text NOT NULL UNIQUE,
    description text
);

CREATE TABLE invoices (
    id serial PRIMARY KEY,
    comp_code text NOT NULL REFERENCES companies ON DELETE CASCADE,
    amt float NOT NULL,
    paid boolean DEFAULT false NOT NULL,
    add_date date DEFAULT CURRENT_DATE NOT NULL,
    paid_date date,
    CONSTRAINT invoices_amt_check CHECK ((amt > (0)::double precision))
);

CREATE TABLE industries (
    code text PRIMARY KEY,
    industry text
);

CREATE TABLE companies_industries (
    comp_code text NOT NULL REFERENCES companies ON DELETE CASCADE,
    industry_code text NOT NULL REFERENCES industries ON DELETE CASCADE,
    PRIMARY KEY(comp_code, industry_code)
);

INSERT INTO companies
  VALUES ('apple', 'Apple Computer', 'IPhones'),
         ('ibm', 'IBM', 'AI Innovators');

INSERT INTO invoices (comp_Code, amt, paid, paid_date)
  VALUES ('ibm', 2000, false, null),
         ('ibm', 2000, true, '2024-03-06'),
         ('apple', 1000, false, null),
         ('apple', 1000, false, null),
         ('apple', 2000, false, null),
         ('apple', 3000, true, '2024-03-05');

INSERT INTO industries
  VALUES ('acct', 'Accounting'),
         ('cell', 'Cellular'),
         ('AI', 'Artificial Intelligence');

INSERT INTO companies_industries
  VALUES ('apple', 'cell'),
         ('apple', 'acct'),
         ('ibm', 'acct'),
         ('ibm', 'AI');