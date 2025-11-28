--------------- Employee history ------------------
SELECT
    t.code,
    t.firstname,
    t.lastname,
    h.historyid,
    c.name AS company,
    d.name AS department,
    di.name AS division,
    p.name AS position,
    le.name AS leveln,
    h.begindate,
    h.enddate,
    h.labourcondition
FROM hrms_prod.tblemployee t
JOIN hrms_prod.tblempemplhist h
    ON t.empid = h.empid
LEFT JOIN hrms_prod.tblcompany c
    ON h.companyid = c.companyid
LEFT JOIN hrms_prod.tbldepartment d
    ON h.depid = d.depid
LEFT JOIN hrms_prod.sidivision di
    ON t.divisionid = di.divisionid
LEFT JOIN hrms_prod.tblposition p
    ON h.positionid = p.positionid
LEFT JOIN hrms_prod.silevel le
    ON h.levelid = le.levelid
WHERE t.empid IN (
    6366, 6117, 15448, 25711, 6369, 11405
)
ORDER BY t.firstname, h.historyid;


--------------- Education  ------------------

SELECT
    em.firstname,
    e.fromdate,
    e.todate,
    co.name AS country,
    un.name AS university,
    l.name AS educationlevel,
    pr.name AS profession,
    e.gpa,
    e.certificateno
FROM hrms_prod.hrempeducation e
JOIN hrms_prod.sieducationlevel l
    ON e.educationlevelid = l.educationlevelid
JOIN hrms_prod.sieducationtype et
    ON et.educationtypeid = e.educationtypeid
JOIN hrms_prod.siprofession pr
    ON pr.professionid = e.professionid
JOIN hrms_prod.siuniversity un
    ON un.universityid = e.universityid
JOIN hrms_prod.sicountry co
    ON co.countryid = e.countryid
JOIN hrms_prod.sidivision di
    ON di.divisionid = e.divisionid
JOIN hrms_prod.tblemployee em
    ON em.empid = e.empid
WHERE e.empid IN (
    6366, 6117, 15448, 25711, 6369, 11405
)
ORDER BY em.firstname;



--------------- Training  ------------------

SELECT
    em.empid,
    em.firstname,
    em.lastname,
    st.trainingid,
    rt.begindate AS surgalt_ehleh_ognoo,
    rt.enddate   AS surgalt_duusah_ognoo,
    st.name      AS surgalt_ner,
    st.duration  AS suuh_yostoi_tsag,
    rt.duration  AS suusan_tsag,
    ex.total_expense AS tulbur,
    ev.score AS unelgee,
    tm.name AS surgalt_helber,
    sc.name AS surgalt_turul,
    ce.name AS surgalt_baiguullaga,
    sk.skillid,
    sk.trainingid,
    sl.name AS surgalt_angilal
FROM hrms_prod.hremptraining et
JOIN hrms_prod.tblemployee em
    ON em.empid = et.empid
JOIN hrms_prod.sitraining st
    ON et.trainingid = st.trainingid
LEFT JOIN hrms_prod.hrrealtraining rt
    ON et.realtrainingid = rt.realtrainingid
LEFT JOIN (
    SELECT
        re.realtrainingid,
        SUM(re.expense) AS total_expense
    FROM hrms_prod.hrrealtrexpense re
    JOIN hrms_prod.sitrainingexpense se
        ON re.trainingexpenseid = se.trainingexpenseid
    GROUP BY re.realtrainingid
) ex
    ON ex.realtrainingid = et.realtrainingid
LEFT JOIN hrms_prod.hrrealtreval ev
    ON et.realtrainingid = ev.realtrainingid
LEFT JOIN hrms_prod.hrtrainingmode tm
    ON st.trainingmodeid = tm.trainingmodeid
LEFT JOIN hrms_prod.sitrainingclass sc
    ON st.trainingclassid = sc.trainingclassid
LEFT JOIN hrms_prod.sitrainingskill sk
    ON st.trainingid = sk.trainingid
LEFT JOIN hrms_prod.siskill sl
    ON sk.skillid = sl.skillid
LEFT JOIN hrms_prod.sieducationcenter ce
    ON st.educenterid = ce.educenterid
WHERE et.empid IN (
    6366, 6117, 15448, 25711, 6369, 11405
);



--------------- Foreign Language Skills  ------------------

SELECT
    em.entryid,
    em.empid,
    em.forlanguageid,
    l.name AS language,
    leLis.name AS listeninglevel,
    leSpe.name AS speakinglevel,
    leRead.name AS readinglevel,
    leWrit.name AS writinglevel
FROM hrms_prod.hrempforlanguage em
LEFT JOIN hrms_prod.siforlanguage l
    ON em.forlanguageid = l.forlanguageid
LEFT JOIN hrms_prod.siforlanguagelevel leLis
    ON em.listeninglevelid = leLis.forlanguagelevelid
LEFT JOIN hrms_prod.siforlanguagelevel leSpe
    ON em.speakinglevelid = leSpe.forlanguagelevelid
LEFT JOIN hrms_prod.siforlanguagelevel leRead
    ON em.readinglevelid = leRead.forlanguagelevelid
LEFT JOIN hrms_prod.siforlanguagelevel leWrit
    ON em.writinglevelid = leWrit.forlanguagelevelid
WHERE em.empid IN (
    6366, 6117, 15448, 25711, 6369, 11405
);




-----------Family Members ------------


SELECT
    r.name,
    f.lastname,
    f.firstname,
    f.famregno,
    f.birthdate,
    f.professionid,
    f.jobid,
    f.orgname,
    f.note,
    f.phone
FROM hrms_prod.hrempfamily f
JOIN hrms_prod.sirelative r
    ON f.relativeid = r.relativeid
WHERE f.empid IN (
    6366, 6117, 15448, 25711, 6369, 11405
);




-----------job + profession name ------------
SELECT
    r.name,
    f.lastname,
    f.firstname,
    f.famregno,
    f.birthdate,
    f.professionid,
    pr.name AS profname,
    f.jobid,
    j.name AS jobname,
    f.orgname,
    f.note,
    f.phone
FROM hrms_prod.hrempfamily f
JOIN hrms_prod.sirelative r
    ON f.relativeid = r.relativeid
JOIN hrms_prod.sijob j
    ON f.jobid = j.jobid
JOIN hrms_prod.sijobtype jt
    ON j.jobtypeid = jt.jobtypeid
JOIN hrms_prod.siprofession pr
    ON f.professionid = pr.professionid
WHERE f.empid IN (
    6366, 6117, 15448, 25711, 6369, 11405
);



-----------AWARD ------------

SELECT
    a.orderid,
    a.awarddate,
    a.amount,
    a.note,
    ad.name AS adtype,
    re.name AS reason,
    e.companyid,
    c.name AS compname
FROM hrms_prod.hrorderaward a
JOIN hrms_prod.sihradtype ad
    ON a.adtypeid = ad.adtypeid
JOIN hrms_prod.sihrreason re
    ON a.reasons = TO_CHAR(re.reasonid)
JOIN hrms_prod.tblemployee e
    ON a.empid = e.empid
JOIN hrms_prod.tblcompany c
    ON e.companyid = c.companyid;


-----------Certificates ------------

SELECT
    ec.certificateid,
    ec.certificateno,
    ec.certificatedate,
    ec.note,
    s.certificateid,
    s.name AS certficatename,
    s.code AS code,
    st.name AS typename,
    st.code AS typecode,
    ec.expirydate
FROM hrms_prod.hrempcertificate ec
JOIN hrms_prod.sicertificate s
    ON ec.certificateid = s.certificateid
JOIN hrms_prod.sicertificatetype st
    ON s.certificatetypeid = st.certificatetypeid;

