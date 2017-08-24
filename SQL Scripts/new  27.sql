
[:TEMP.IMSI] := #SUBSTR([:RADIUS.3GPP-IMSI],{0},{7});
[:TEMP.SGSN-MCC] := #SUBSTR([:RADIUS.3GPP-SGSN-MCC-MNC],{0},{3});
--Nar Zone Checking Start
IF [:TEMP.IMSI] = {4000410} THEN
		IF [:CBOSS.Service-BPlan]={POSTPAID} THEN
			IF [:TEMP.SGSN-MCC] IN 
				{257},
				{401},
				{437},
				{259},
				{250},
				{436}
				THEN [:RADIUS.Class]:={csg:billing_plan=}||{POSTPAID_ZONE1}; 
				ELSE [:RADIUS.Class]:={csg:billing_plan=}||{ZONE1};
			END IF;
		END IF;
	ELSIF [:TEMP.SGSN-MCC] IN 
				{232},
				{206},
				{302},
				{248},
				{282},
				{202},
				{418},
				{242},
				{286},
				{255},
				{434},
				{421}
	THEN [:RADIUS.Class]:={csg:billing_plan=}||{POSTPAID_ZONE2}; 
	ELSE [:RADIUS.Class]:={csg:billing_plan=}||{ZONE2};
END IF;
END IF;
ELSIF [:TEMP.SGSN-MCC] IN 
{276},
{218},
{284},
{238},
{244},
{208},
{262},
{216},
{274},
{432},
{272},
{222},
{247},
{246},
{270},
{278},
{297},
{204},
{422},
{260},
{268},
{226},
{525},
{231},
{293},
{655},
{214},
{240},
{901},
{228},
{438},
{234},
{452}
THEN [:RADIUS.Class]:={csg:billing_plan=}||{POSTPAID_ZONE3}; 
ELSE [:RADIUS.Class]:={csg:billing_plan=}||{ZONE3};
END IF;
END IF;
ELSIF [:TEMP.SGSN-MCC] IN 
{603},
{470},
{724},
{460},
{612},
{219},
{230},
{370},
{602},
{706},
{620},
{738},
{454},
{404},
{510},
{425},
{234},
{416},
{450},
{419},
{455},
{646},
{502},
{472},
{617},
{334},
{428},
{649},
{621},
{410},
{714},
{537},
{716},
{515},
{330},
{427},
{420},
{608},
{220},
{413},
{634},
{746},
{466},
{640},
{520},
{374},
{424},
{310}
THEN [:RADIUS.Class]:={csg:billing_plan=}||{POSTPAID_ZONE4}; 
ELSE [:RADIUS.Class]:={csg:billing_plan=}||{ZONE4};
END IF;
END IF;
ELSIF NOT [:TEMP.SGSN-MCC] = {400}
THEN [:RADIUS.Class]:={csg:billing_plan=}||{POSTPAID_ZONE0}; 
ELSE [:RADIUS.Class]:={csg:billing_plan=}||{ZONE0};
END IF;
END IF;
--Nar Zone Checking END
--AF-VF Zone Checking Start
IF [:TEMP.IMSI] = {4000420} THEN
IF [:CBOSS.Service-BPlan]={POSTPAID} THEN
IF [:TEMP.SGSN-MCC] IN 
{232},
{257},
{206},
{208},
{262},
{216},
{222},
{401},
{437},
{259},
{204},
{268},
{250},
{436},
{286},
{234}
THEN [:RADIUS.Class]:={csg:billing_plan=}||{POSTPAID_ZONE1}; 
ELSE [:RADIUS.Class]:={csg:billing_plan=}||{ZONE1};
END IF;
END IF;
ELSIF [:TEMP.SGSN-MCC] IN 
{302},
{248},
{248},
{282},
{282},
{282},
{202},
{418},
{242},
{226},
{226},
{255},
{255},
{255},
{255},
{255},
{434},
{434},
{434},
{421}
THEN [:RADIUS.Class]:={csg:billing_plan=}||{POSTPAID_ZONE2}; 
ELSE [:RADIUS.Class]:={csg:billing_plan=}||{ZONE2};
END IF;
END IF;
ELSIF [:TEMP.SGSN-MCC] IN 
{276},
{218},
{284},
{238},
{244},
{274},
{432},
{272},
{247},
{246},
{270},
{278},
{297},
{422},
{260},
{525},
{231},
{293},
{655},
{214},
{240},
{901},
{228},
{438},
{452}
THEN [:RADIUS.Class]:={csg:billing_plan=}||{POSTPAID_ZONE3}; 
ELSE [:RADIUS.Class]:={csg:billing_plan=}||{ZONE3};
END IF;
END IF;
ELSIF [:TEMP.SGSN-MCC] IN 
{603},
{470},
{724},
{460},
{612},
{219},
{230},
{370},
{602},
{706},
{620},
{738},
{454},
{404},
{510},
{425},
{234},
{416},
{450},
{419},
{455},
{646},
{502},
{472},
{617},
{334},
{428},
{649},
{621},
{410},
{714},
{537},
{716},
{515},
{330},
{427},
{420},
{608},
{220},
{413},
{634},
{746},
{466},
{640},
{520},
{374},
{424},
{310}
THEN [:RADIUS.Class]:={csg:billing_plan=}||{POSTPAID_ZONE4}; 
ELSE [:RADIUS.Class]:={csg:billing_plan=}||{ZONE4};
END IF;
END IF;
ELSIF NOT [:TEMP.SGSN-MCC] = {400}
THEN [:RADIUS.Class]:={csg:billing_plan=}||{POSTPAID_ZONE0}; 
ELSE [:RADIUS.Class]:={csg:billing_plan=}||{ZONE0};
END IF;
END IF;
--AF-VF Zone Checking End