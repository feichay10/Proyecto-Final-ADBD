ALTER TABLE platos
ADD CONSTRAINT chk_tipo_plato
CHECK (tipo IN ('Entrante', 'Principal', 'Postre'));

ALTER TABLE seres_vivos
ADD CONSTRAINT chk_tipo_seres_vivos
CHECK (tipo IN ('Animal', 'Planta'));