-- Script para verificar la estructura de las tablas leads y lead_concesionario_marca
-- Ejecuta este script en tu cliente PostgreSQL (DBeaver, pgAdmin, etc.)

\echo '========================================='
\echo 'VERIFICACIÓN DE ESTRUCTURA DE TABLAS'
\echo '========================================='
\echo ''

-- Verificar columnas de la tabla leads
\echo '1. Verificando tabla: leads'
\echo '-------------------------------------------'
SELECT
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'leads'
ORDER BY ordinal_position;

\echo ''
\echo '2. Columnas REQUERIDAS en tabla leads:'
\echo '   - lead_id (PK)'
\echo '   - nombre'
\echo '   - apellidos'
\echo '   - email'
\echo '   - telefono'
\echo '   - estado_actual'
\echo '   - ciudad'
\echo '   - cp (o codigo_postal)'
\echo '   - provincia'
\echo '   - activo (boolean, default true)'
\echo '   - opt_out (boolean, default false)'
\echo '   - created_at'
\echo '   - updated_at'
\echo '   - last_contact_at'
\echo ''

-- Verificar columnas de la tabla lead_concesionario_marca
\echo '3. Verificando tabla: lead_concesionario_marca'
\echo '-------------------------------------------'
SELECT
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'lead_concesionario_marca'
ORDER BY ordinal_position;

\echo ''
\echo '4. Columnas REQUERIDAS en tabla lead_concesionario_marca:'
\echo '   - lead_concesionario_marca_id (PK)'
\echo '   - lead_id (FK -> leads)'
\echo '   - concesionario_marca_id (FK -> concesionario_marca)'
\echo '   - modelo'
\echo '   - estado'
\echo '   - presupuesto_min'
\echo '   - presupuesto_max'
\echo '   - fecha_entrada'
\echo '   - fecha_cierre'
\echo '   - notas'
\echo '   - motivo_perdida'
\echo '   - source'
\echo ''

-- Verificar que las tablas relacionadas existan
\echo '5. Verificando tablas relacionadas:'
\echo '-------------------------------------------'
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN (
    'leads',
    'lead_concesionario_marca',
    'concesionario_marca',
    'concesionario',
    'marca',
    'call_logs',
    'lead_messages',
    'lead_notes'
  )
ORDER BY table_name;

\echo ''
\echo '6. Contando registros en tablas principales:'
\echo '-------------------------------------------'
SELECT 'leads' as tabla, COUNT(*) as registros FROM public.leads
UNION ALL
SELECT 'lead_concesionario_marca' as tabla, COUNT(*) as registros FROM public.lead_concesionario_marca
UNION ALL
SELECT 'call_logs' as tabla, COUNT(*) as registros FROM public.call_logs
UNION ALL
SELECT 'lead_messages' as tabla, COUNT(*) as registros FROM public.lead_messages;

\echo ''
\echo '========================================='
\echo 'VERIFICACIÓN COMPLETADA'
\echo '========================================='
