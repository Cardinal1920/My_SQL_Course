---- Build the English Premier League results table from the match record

SELECT
    m.[Date]
    ,m.HomeTeam
    ,m.AwayTeam
    ,m.FTHG
    ,m.FTAG
    ,FTR
FROM
    FootballMatch m;    
    
SELECT * FROM
    FootballMatch m
--WHERE m.[Date] >= '2023-01-01' AND m.[Date] < '2024-01-01'

---- Build the English Premier League results table from the match record
    
    SELECT
        m.[Date]
        ,m.HomeTeam
        ,m.AwayTeam
        ,m.FTHG
        ,m.FTAG
        ,FTR
    FROM
        FootballMatch m
    ORDER BY
        m.[Date] DESC
    --LIMIT 5;    
    
--Top 5 most recent matches
    SELECT TOP 5
        m.[Date]
        ,m.HomeTeam
        ,m.AwayTeam
        ,m.FTHG
        ,m.FTAG
        ,m.FTR
    FROM
        FootballMatch m
    ORDER BY
        m.[Date] DESC;


-- Which month had the most matches?
SELECT TOP 1
    FORMAT(m.[Date], 'yyyy-MM') AS Month,
    COUNT(*) AS MatchCount
FROM
    FootballMatch m
GROUP BY
    FORMAT(m.[Date], 'yyyy-MM')
ORDER BY
    MatchCount DESC;


--which dates had more than one match?
SELECT
    m.[Date],
    COUNT(*) AS MatchCount,
    STRING_AGG(m.HomeTeam + ' vs ' + m.AwayTeam, '; ') AS Matches
FROM
    FootballMatch m 
GROUP BY
    m.[Date]    
HAVING
    COUNT(*) > 1    
ORDER BY
    MatchCount DESC, m.[Date] DESC;
    

--which dates had more than one match?
SELECT
    m.[Date],
    COUNT(*) AS MatchCount
FROM
    FootballMatch m
GROUP BY
    m.[Date]
HAVING
    COUNT(*) > 1
ORDER BY
    m.[Date] DESC;


--which dates had more than one match? (with table areas)

SELECT
    m.[Date],
    COUNT(*) AS MatchCount,
    STRING_AGG(m.HomeTeam + ' vs ' + m.AwayTeam, '; ') AS Matches
FROM
    FootballMatch m
GROUP BY
    m.[Date]
HAVING
    COUNT(*) > 1
ORDER BY
    MatchCount DESC, m.[Date] DESC;


--replicate the premire league table as in bbc  sports
  SELECT
    Team,
    SUM(Played) AS Played,
    SUM(Won) AS Won,
    SUM(Drawn) AS Drawn,
    SUM(Lost) AS Lost,
    SUM(GoalsFor) AS GF,
    SUM(GoalsAgainst) AS GA,
    SUM(GoalsFor) - SUM(GoalsAgainst) AS GD,
    SUM(Points) AS Points
FROM (
    -- Home stats
    SELECT
        HomeTeam AS Team,
        COUNT(*) AS Played,
        SUM(CASE WHEN FTHG > FTAG THEN 1 ELSE 0 END) AS Won,
        SUM(CASE WHEN FTHG = FTAG THEN 1 ELSE 0 END) AS Drawn,
        SUM(CASE WHEN FTHG < FTAG THEN 1 ELSE 0 END) AS Lost,
        SUM(FTHG) AS GoalsFor,
        SUM(FTAG) AS GoalsAgainst,
        SUM(CASE WHEN FTHG > FTAG THEN 3 WHEN FTHG = FTAG THEN 1 ELSE 0 END) AS Points
    FROM FootballMatch
    GROUP BY HomeTeam

    UNION ALL

    -- Away stats
    SELECT
        AwayTeam AS Team,
        COUNT(*) AS Played,
        SUM(CASE WHEN FTAG > FTHG THEN 1 ELSE 0 END) AS Won,
        SUM(CASE WHEN FTAG = FTHG THEN 1 ELSE 0 END) AS Drawn,
        SUM(CASE WHEN FTAG < FTHG THEN 1 ELSE 0 END) AS Lost,
        SUM(FTAG) AS GoalsFor,
        SUM(FTHG) AS GoalsAgainst,
        SUM(CASE WHEN FTAG > FTHG THEN 3 WHEN FTAG = FTHG THEN 1 ELSE 0 END) AS Points
    FROM FootballMatch
    GROUP BY AwayTeam
) AS Combined
GROUP BY Team
ORDER BY Points DESC, GD DESC, GF DESC, Team ASC;



-- This query selects the home team, goals for, goals against, and result (W, D, L) from the FootballMatch table.
SELECT      
    m.HomeTeam AS Team,
    m.FTHG AS GoalsFor,
    m.FTAG AS GoalsAgainst,
    CASE 
        WHEN m.FTHG > m.FTAG THEN 'W'
        WHEN m.FTHG = m.FTAG THEN 'D'
        ELSE 'L'
    END AS Result
FROM
    FootballMatch m;

-- results from home team perspective
SELECT      
    m.HomeTeam  as Team
    ,m.FTHG AS GoalsFor
    ,m.FTAG  AS GoalsAgainst
--    ,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' WHEN 'A' THEN 'L' END As Result
    --,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' ELSE 'L' END As Result
    ,CASE when m.FTHG > m.FTAG then 'W' when M.FTHG = M.FTAG then 'D' else 'L' end as Result
FROM
    FootballMatch m
 
-- results from AWAY team perspective
SELECT      
    m.AwayTeam  as Team
    ,m.FTAG AS GoalsFor
    ,m.FTHG  AS GoalsAgainst
    ,CASE m.FTR WHEN 'A' THEN 'W' WHEN 'D' THEN 'D' WHEN 'H' THEN 'L' END As Result
FROM
    FootballMatch m


--replicate the primire league table as in bbc  sports using the database
SELECT
    Team,
    SUM(Played) AS Played,
    SUM(Won) AS Won,
    SUM(Drawn) AS Drawn,
    SUM(Lost) AS Lost,
    SUM(GoalsFor) AS GF,
    SUM(GoalsAgainst) AS GA,
    SUM(GoalsFor) - SUM(GoalsAgainst) AS GD,
    SUM(Points) AS Points
FROM (
    -- Home stats
    SELECT
        HomeTeam AS Team,
        COUNT(*) AS Played,
        SUM(CASE WHEN FTHG > FTAG THEN 1 ELSE 0 END) AS Won,
        SUM(CASE WHEN FTHG = FTAG THEN 1 ELSE 0 END) AS Drawn,
        SUM(CASE WHEN FTHG < FTAG THEN 1 ELSE 0 END) AS Lost,
        SUM(FTHG) AS GoalsFor,
        SUM(FTAG) AS GoalsAgainst,
        SUM(CASE WHEN FTHG > FTAG THEN 3 WHEN FTHG = FTAG THEN 1 ELSE 0 END) AS Points
    FROM FootballMatch
    GROUP BY HomeTeam

    UNION ALL

    -- Away stats
    SELECT
        AwayTeam AS Team,
        COUNT(*) AS Played,
        SUM(CASE WHEN FTAG > FTHG THEN 1 ELSE 0 END) AS Won,
        SUM(CASE WHEN FTAG = FTHG THEN 1 ELSE 0 END) AS Drawn,
        SUM(CASE WHEN FTAG < FTHG THEN 1 ELSE 0 END) AS Lost,
        SUM(FTAG) AS GoalsFor,
        SUM(FTHG) AS GoalsAgainst,
        SUM(CASE WHEN FTAG > FTHG THEN 3 WHEN FTAG = FTHG THEN 1 ELSE 0 END) AS Points
    FROM FootballMatch
    GROUP BY AwayTeam
) AS Combined
GROUP BY Team
ORDER BY Points DESC, GD DESC, GF DESC, Team ASC;



-- results from home team perspective

DROP TABLE IF EXISTS #EPLResults;
SELECT      
    m.HomeTeam  as Team
    ,m.FTHG AS GoalsFor
    ,m.FTAG  AS GoalsAgainst
--    ,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' WHEN 'A' THEN 'L' END As Result
    --,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' ELSE 'L' END As Result
    ,CASE when m.FTHG > m.FTAG then 'W' when M.FTHG = M.FTAG then 'D' else 'L' end as Result

INTO #EPLResults

FROM
    FootballMatch m
UNION ALL
-- results from AWAY team perspective
SELECT      
    m.AwayTeam  as Team
    ,m.FTAG AS GoalsFor
    ,m.FTHG  AS GoalsAgainst
    ,CASE m.FTR WHEN 'A' THEN 'W' WHEN 'D' THEN 'D' WHEN 'H' THEN 'L' END As Result
FROM
    FootballMatch m

SELECT * from #EPLResults

--goup by team to build teh league table

SELECT
    r.Team
    , COUNT(*) as Played
    , sum(r.GoalsFor) as GoalsFor
    , sum(r.GoalsAgainst) as GoalsAgainst
    , sum(r.GoalsFor) - sum(r.GoalsAgainst) as GD
    , sum(CASE WHEN r.Result = 'W' THEN 1 ELSE 0 END) aS Won
    , sum(CASE WHEN r.Result = 'D' THEN 1 ELSE 0 END) aS Drawn
    , sum(CASE WHEN r.Result = 'L' THEN 1 ELSE 0 END) aS Lost
    , SUM(CASE r.Result WHEN 'W' THEN 3 WHEN 'D' THEN 1 ELSE 0 END ) as Points
from #EPLResults r
GROUP BY r.Team
ORDER BY r.Team;



