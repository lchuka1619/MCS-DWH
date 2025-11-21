SELECT t.code,t.FIRSTNAME ,t.LASTNAME ,h.HISTORYID ,--d.*,
c.name AS company,d.name AS department,di.name AS division,p.name AS position,le.name AS leveln,
h.begindate,h.enddate, h.LABOURCONDITION 
--,h.* 
FROM 
HRMS_PROD.TBLEMPLOYEE t,
HRMS_PROD.TBLEMPEMPLHIST h ,
hrms_prod.tblcompany c,
hrms_prod.tbldepartment d ,
HRMS_PROD.tblposition p,
hrms_prod.SIDIVISION di,
hrms_prod.silevel le
WHERE t.EMPID  in(
6366,
6117,
15448,
25711,
6369,
11405
)
AND t.empid=h.empid
AND h.companyid=c.companyid

AND h.companyid=c.companyid(+)
AND h.depid=d.depid(+)
AND t.divisionid=di.DIVISIONid(+)
AND h.positionid=p.positionid(+)
AND h.levelid=le.levelid(+)
ORDER BY t.firstname,h.HISTORYID 

#######  Education ###############
SELECT em.firstname,
e.fromdate,e.todate,co.name country,un.name UNIVERSITY,l.NAME EDUCATIONLEVEL,pr.name PROFESSION,
e.gpa,e.certificateno
FROM HRMS_PROD.HREMPEDUCATION e ,
HRMS_PROD.SIEDUCATIONLEVEL l,
HRMS_PROD.sieducationtype et,
HRMS_PROD.SIPROFESSION pr,
HRMS_PROD.SIUNIVERSITY un,
hrms_prod.SIDIVISION di,
hrms_prod.sicountry co,
hrms_prod.tblemployee em
WHERE e.EDUCATIONLEVELID = l.EDUCATIONLEVELID
AND e.EMPID  in(
6366,
6117,
15448,
25711,
6369,
11405
)
AND et.educationtypeid = e.educationtypeid 
AND pr.professionid = e.professionid 
AND un.universityid = e.universityid 
AND co.countryid = e.countryid 
AND di.divisionid = e.divisionid 
AND em.empid = e.empid 
ORDER BY em.FIRSTNAME 





SELECT 
    em.EMPID,
    em.FIRSTNAME,
    em.LASTNAME,
    st.trainingid,

    -- Бодит сургалтын огноо
    rt.begindate AS SURGALT_EHLEH_OGNOO,
    rt.ENDDATE   AS SURGALT_DUUSAH_OGNOO,
    -- Сургалтын нэр
    st.name AS SURGALT_NER,

    -- Сургалтын төлөвлөгөөт огноо (if exists)
   -- et.PLANDATE AS TULUULSEN_OGNOO,

    -- Суух ёстой цаг
    st.duration AS SUUH_YOSTOI_TSAG,

    -- Суусан цаг (real training)
    rt.duration AS SUUSAN_TSAG,
    
--    -- Нийт төлбөр (sum)
    ex.TOTAL_EXPENSE AS TULBUR,
    

    -- Сургалтын үнэлгээ
    ev.SCORE AS UNELGEE,
    -- Сургалтын хэлбэр
    tm.name AS SURGALT_HELBER,

    -- Сургалтын төрөл
    sc.NAME AS SURGALT_TURUL,

    -- Сургалтын хөтөлбөр
    --pl.name AS SURGALT_HUTULBUR,
    -- Сургалт явуулсан байгууллага
    ce.NAME AS SURGALTIIN_BAIGUULLAGA,
    sk.skillid,sk.trainingid,
    -- Сургалтын ангилал
    sl.NAME AS SURGALT_ANGILAL
FROM HRMS_PROD.HREMPTRAINING et
JOIN HRMS_PROD.TBLEMPLOYEE em 
        ON em.EMPID = et.EMPID

-- TRAINING MASTER
JOIN HRMS_PROD.SITRAINING st 
        ON et.TRAININGID = st.TRAININGID

-- REAL TRAINING EVENT
LEFT JOIN  HRMS_PROD.HRREALTRAINING rt
        ON et.REALTRAININGID = rt.REALTRAININGID
LEFT JOIN (
    SELECT 
        re.REALTRAININGID,
        SUM(re.EXPENSE) AS TOTAL_EXPENSE
    FROM HRMS_PROD.HRREALTREXPENSE re
    JOIN HRMS_PROD.SITRAININGEXPENSE se
         ON re.TRAININGEXPENSEID = se.TRAININGEXPENSEID
    GROUP BY re.REALTRAININGID
) ex ON ex.REALTRAININGID = et.REALTRAININGID
-- EVALUATION
LEFT JOIN HRMS_PROD.HRREALTREVAL ev
        ON et.REALTRAININGID = ev.REALTRAININGID

        --SELECT * FROM  HRMS_PROD.HRTRAININGPLAN rt
-- TRAINING MODE
LEFT JOIN HRMS_PROD.HRTRAININGMODE tm
        ON st.TRAININGMODEID = tm.TRAININGMODEID

-- TRAINING CLASS
LEFT JOIN HRMS_PROD.SITRAININGCLASS sc
        ON st.TRAININGCLASSID = sc.TRAININGCLASSID
-- TRAINING SKILL
LEFT JOIN HRMS_PROD.SITRAININGSKILL sk
        ON st.TRAININGID = sk.TRAININGID
LEFT JOIN HRMS_PROD.SISKILL sl
        ON  sk.SKILLID =sl.SKILLID 
        
--LEFT JOIN HRMS_PROD.HRTRAININGPLANDTL pl
--        ON et.TRAININGID = pl.TRAININGID
        
-- EDUCATION CENTER
LEFT JOIN HRMS_PROD.SIEDUCATIONCENTER ce
        ON st.EDUCENTERID = ce.EDUCENTERID
WHERE 
et.EMPID  in(
6366,
6117,
15448,
25711,
6369,
11405
)





SELECT em.entryid, em.empid, em.FORLANGUAGEID ,l.name
,leLis.name listeningLevel
,leSpe.name SpeakingLevel
,leRead.name ReadingLevel
,leWrit.name WritingLevel
FROM 
HRMS_PROD.HREMPFORLANGUAGE em,
HRMS_PROD.SIFORLANGUAGE l,
HRMS_PROD.SIFORLANGUAGELEVEL leLis,
HRMS_PROD.SIFORLANGUAGELEVEL leSpe,
HRMS_PROD.SIFORLANGUAGELEVEL leRead,
HRMS_PROD.SIFORLANGUAGELEVEL leWrit
WHERE 
--em.empid = l.empid AND 
em.forlanguageid = l.forlanguageid(+)
AND em.LISTENINGLEVELID = leLis.forlanguagelevelid(+)
AND em.SPEAKINGLEVELID  = leSpe.forlanguagelevelid(+)
AND em.READINGLEVELID  = leRead.forlanguagelevelid(+)
AND em.WRITINGLEVELID  = leWrit.forlanguagelevelid(+)
AND  em.EMPID  in(
6366,
6117,
15448,
25711,
6369,
11405
)

