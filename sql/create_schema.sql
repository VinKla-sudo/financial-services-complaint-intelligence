CREATE TABLE public.complaints_2025 (
    date_received DATE NOT NULL,
    product TEXT NOT NULL,
    sub_product TEXT,
    issue TEXT NOT NULL,
    sub_issue TEXT,
    company_public_response TEXT,
    company TEXT NOT NULL,
    state VARCHAR(2),
    zip_code VARCHAR(10),
    tags TEXT,
    submitted_via TEXT,
    date_sent_to_company DATE,
    company_response_to_consumer TEXT,
    timely_response TEXT,
    complaint_id BIGINT NOT NULL
);