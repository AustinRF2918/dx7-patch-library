CREATE DOMAIN DX7_HIGH_RES_VALUE AS SMALLINT DEFAULT 0 NOT NULL CHECK (VALUE >= 0 AND VALUE <= 99);
CREATE TYPE wave_type AS ENUM ('triangle', 'saw_down', 'saw_up', 'square', 'sine', 'sample_and_hold');

CREATE TABLE patch (
    id SERIAL PRIMARY KEY,
    name CHAR (60) NOT NULL,

    pitch_rate_1 DX7_HIGH_RES_VALUE,
    pitch_rate_2 DX7_HIGH_RES_VALUE,
    pitch_rate_3 DX7_HIGH_RES_VALUE,
    pitch_rate_4 DX7_HIGH_RES_VALUE,

    pitch_level_1 DX7_HIGH_RES_VALUE,
    pitch_level_2 DX7_HIGH_RES_VALUE,
    pitch_level_3 DX7_HIGH_RES_VALUE,
    pitch_level_4 DX7_HIGH_RES_VALUE,

    feedback DX7_HIGH_RES_VALUE,

    osc_key_sync_enabled BOOLEAN DEFAULT FALSE NOT NULL,

    lfo_delay DX7_HIGH_RES_VALUE,
    lfo_amp_mod_depth DX7_HIGH_RES_VALUE,

    lfo_key_sync BOOLEAN DEFAULT FALSE NOT NULL,

    lfo_wave wave_type DEFAULT 'triangle' NOT NULL,

    mod_sense_pitch SMALLINT DEFAULT 0 NOT NULL CHECK (mod_sense_pitch >= 0 AND mod_sense_pitch <= 7),

    transpose SMALLINT DEFAULT 0 NOT NULL CHECK (transpose >= 0 AND mod_sense_pitch <= 48)
);
