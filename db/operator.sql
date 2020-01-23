CREATE DOMAIN DX7_HIGH_RES_VALUE AS SMALLINT DEFAULT 0 NOT NULL CHECK (VALUE >= 0 AND VALUE <= 99);
CREATE TYPE level_scale_mode AS ENUM ('negative_linear', 'negative_exponential', 'linear', 'exponential');
CREATE TYPE oscillator_mode AS ENUM ('ratio', 'fixed');

CREATE TABLE operator (
    id SERIAL PRIMARY KEY,

    envelope_generator_rate_1 DX7_HIGH_RES_VALUE,
    envelope_generator_rate_2 DX7_HIGH_RES_VALUE,
    envelope_generator_rate_3 DX7_HIGH_RES_VALUE,
    envelope_generator_rate_4 DX7_HIGH_RES_VALUE,

    envelope_generator_level_1 DX7_HIGH_RES_VALUE,
    envelope_generator_level_2 DX7_HIGH_RES_VALUE,
    envelope_generator_level_3 DX7_HIGH_RES_VALUE,
    envelope_generator_level_4 DX7_HIGH_RES_VALUE,

    level_scale_break_point DX7_HIGH_RES_VALUE,
    level_scale_left_depth DX7_HIGH_RES_VALUE,
    level_scale_right_depth DX7_HIGH_RES_VALUE,

    level_scale_left_curve level_scale_mode NOT NULL DEFAULT 'linear',
    level_scale_right_curve level_scale_mode NOT NULL DEFAULT 'linear',

    oscillator_rate_scale SMALLINT DEFAULT 0 NOT NULL CHECK (oscillator_rate_scale >= 0 AND oscillator_rate_scale <= 7),

    amplitude_modulation_sense SMALLINT DEFAULT 0 NOT NULL CHECK (amplitude_modulation_sense >= 0 AND amplitude_modulation_sense <= 3),

    key_velocity_sense SMALLINT DEFAULT 0 NOT NULL CHECK (key_velocity_sense >= 0 AND key_velocity_sense <= 7),

    output_level DX7_HIGH_RES_VALUE,

    oscillator_mode oscillator_mode DEFAULT 'ratio' NOT NULL,

    course_frequency SMALLINT DEFAULT 0 NOT NULL CHECK (course_frequency >= 0 AND course_frequency <= 31),
    fine_frequency DX7_HIGH_RES_VALUE,
    detune SMALLINT DEFAULT 0 NOT NULL CHECK (detune >= 0 AND detune <= 14)
);
