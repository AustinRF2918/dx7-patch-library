CREATE TABLE bank_patch (
    patch_id INTEGER NOT NULL REFERENCES patch(id),
    bank_id INTEGER NOT NULL REFERENCES bank(id),
    bank_position SMALLINT DEFAULT 0 NOT NULL CHECK (bank_position >= 0 AND bank_position <= 31),

    PRIMARY KEY (bank_id, bank_position)
);

