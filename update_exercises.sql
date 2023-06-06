SELECT name AS 'all albums' FROM albums;
UPDATE albums SET sales = sales * 10;
SELECT name AS 'All albums before 1980' FROM albums WHERE release_date < 1980;
UPDATE albums SET release_date = 1800 WHERE release_date < 1980;
SELECT name AS 'Micheal Jackson Albums' FROM albums where artist = 'Michael Jackson';
UPDATE albums SET artist = 'Peter Jackson' WHERE artist = 'Michael Jackson';