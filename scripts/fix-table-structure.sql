-- Script para corregir/agregar columnas faltantes en leads y lead_concesionario_marca
-- IMPORTANTE: Revisa el output de verify-table-structure.sql antes de ejecutar este script

BEGIN;

\echo '========================================='
\echo 'CORRIGIENDO ESTRUCTURA DE TABLAS'
\echo '========================================='
\echo ''

-- ============================================
-- TABLA: leads
-- ============================================

\echo '1. Verificando y agregando columnas faltantes en tabla: leads'
\echo '-------------------------------------------'

-- Agregar columna activo si no existe
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'leads'
          AND column_name = 'activo'
    ) THEN
        ALTER TABLE public.leads ADD COLUMN activo BOOLEAN DEFAULT true NOT NULL;
        RAISE NOTICE 'Columna "activo" agregada a tabla leads';
    ELSE
        RAISE NOTICE 'Columna "activo" ya existe en tabla leads';
    END IF;
END $$;

-- Agregar columna opt_out si no existe
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'leads'
          AND column_name = 'opt_out'
    ) THEN
        ALTER TABLE public.leads ADD COLUMN opt_out BOOLEAN DEFAULT false NOT NULL;
        RAISE NOTICE 'Columna "opt_out" agregada a tabla leads';
    ELSE
        RAISE NOTICE 'Columna "opt_out" ya existe en tabla leads';
    END IF;
END $$;

-- Agregar columna last_contact_at si no existe
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'leads'
          AND column_name = 'last_contact_at'
    ) THEN
        ALTER TABLE public.leads ADD COLUMN last_contact_at TIMESTAMP;
        RAISE NOTICE 'Columna "last_contact_at" agregada a tabla leads';
    ELSE
        RAISE NOTICE 'Columna "last_contact_at" ya existe en tabla leads';
    END IF;
END $$;

-- Verificar que exista created_at
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'leads'
          AND column_name = 'created_at'
    ) THEN
        ALTER TABLE public.leads ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL;
        RAISE NOTICE 'Columna "created_at" agregada a tabla leads';
    ELSE
        RAISE NOTICE 'Columna "created_at" ya existe en tabla leads';
    END IF;
END $$;

-- Verificar que exista updated_at
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'leads'
          AND column_name = 'updated_at'
    ) THEN
        ALTER TABLE public.leads ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL;
        RAISE NOTICE 'Columna "updated_at" agregada a tabla leads';
    ELSE
        RAISE NOTICE 'Columna "updated_at" ya existe en tabla leads';
    END IF;
END $$;

-- ============================================
-- TABLA: lead_concesionario_marca
-- ============================================

\echo ''
\echo '2. Verificando y agregando columnas faltantes en tabla: lead_concesionario_marca'
\echo '-------------------------------------------'

-- Agregar columna fecha_cierre si no existe
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'lead_concesionario_marca'
          AND column_name = 'fecha_cierre'
    ) THEN
        ALTER TABLE public.lead_concesionario_marca ADD COLUMN fecha_cierre TIMESTAMP;
        RAISE NOTICE 'Columna "fecha_cierre" agregada a tabla lead_concesionario_marca';
    ELSE
        RAISE NOTICE 'Columna "fecha_cierre" ya existe en tabla lead_concesionario_marca';
    END IF;
END $$;

-- Agregar columna motivo_perdida si no existe
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'lead_concesionario_marca'
          AND column_name = 'motivo_perdida'
    ) THEN
        ALTER TABLE public.lead_concesionario_marca ADD COLUMN motivo_perdida TEXT;
        RAISE NOTICE 'Columna "motivo_perdida" agregada a tabla lead_concesionario_marca';
    ELSE
        RAISE NOTICE 'Columna "motivo_perdida" ya existe en tabla lead_concesionario_marca';
    END IF;
END $$;

-- Agregar columna source si no existe
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'lead_concesionario_marca'
          AND column_name = 'source'
    ) THEN
        ALTER TABLE public.lead_concesionario_marca ADD COLUMN source VARCHAR(100);
        RAISE NOTICE 'Columna "source" agregada a tabla lead_concesionario_marca';
    ELSE
        RAISE NOTICE 'Columna "source" ya existe en tabla lead_concesionario_marca';
    END IF;
END $$;

\echo ''
\echo '========================================='
\echo 'CORRECCIÓN COMPLETADA'
\echo 'Por favor ejecuta verify-table-structure.sql nuevamente para confirmar'
\echo '========================================='

COMMIT;
