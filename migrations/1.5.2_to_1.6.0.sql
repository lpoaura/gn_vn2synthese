BEGIN;
ALTER TABLE src_lpodatas.t_c_synthese_extended
    ADD COLUMN comment_form TEXT;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.comment_form IS 'Commentaire du formulaire';

ALTER TABLE src_lpodatas.t_c_synthese_extended
    ADD COLUMN anonymous_in_export BOOLEAN DEFAULT FALSE;

COMMENT ON COLUMN src_lpodatas.t_c_synthese_extended.anonymous_in_export IS 'La donnée doit-elle être transmise anonymement ?';

COMMIT;
