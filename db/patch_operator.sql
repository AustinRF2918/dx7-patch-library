CREATE TABLE patch_operator (
    operator_id INTEGER NOT NULL REFERENCES operator(id),
    patch_id INTEGER NOT NULL REFERENCES patch(id),

    patch_position SMALLINT DEFAULT 0 NOT NULL CHECK (patch_position >= 0 AND patch_position <= 5),
    enabled BOOLEAN DEFAULT FALSE NOT NULL,

    PRIMARY KEY (patch_id, patch_position)
);
