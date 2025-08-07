								-- ####################### DATA CONTROL LANGUAGE [DCL] #######################
														-- 1. GRANT
														-- 2. DELETE

-- TASK-1: GRANTING ACCESS OF THE DATABASE:

-- [CASE-I]: GRANTING ONLY SELECT & UPDATE FEATURES TO USER: -
GRANT SELECT, UPDATE ON Customers TO Tom, Jerry;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [CASE-II]: GRANTING FULL CONTROL & SUPERUSER PRIVILEDGES OF DB: -
GRANT SYSDBA TO John;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- TASK-2: REVOKING ACCESS OF THE DATABASE:
REVOKE SELECT, UPDATE ON Customers FROM Tom, Jerry;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------