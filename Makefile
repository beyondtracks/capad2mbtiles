all: unzip labels geojson mbtiles

download:
	mkdir -p data
	wget -O data/CAPAD_2016_terrestrial.zip "http://www.environment.gov.au/fed/catalog/search/resource/downloadData.page?uuid=%7B4448CACD-9DA8-43D1-A48F-48149FD5FCFD%7D#"
	wget -O data/CAPAD_2016_marine.zip 'http://www.environment.gov.au/fed/catalog/search/resource/downloadData.page?uuid={AF4EE98E-7F09-4172-B95E-067AB8FA10FC}#'

unzip:
	unzip -j data/CAPAD_2016_terrestrial.zip -d data
	unzip -j data/CAPAD_2016_marine.zip -d data

labels:
	ogr2ogr -f GeoJSON -sql "SELECT NAME AS name, TYPE AS type, TYPE_ABBR as type_abbr, IUCN as iucn FROM CAPAD_2016_terrestrial WHERE NAME NOT LIKE '%Unnamed%'" data/capad_2016_terrestrial.labelpolygon.geojson data/CAPAD_2016_terrestrial.shp
	geojson-polygon-labels --include-minzoom=0-14 --label polylabel --style combine data/capad_2016_terrestrial.labelpolygon.geojson > data/capad_2016_terrestrial.label.geojson
	rm data/capad_2016_terrestrial.labelpolygon.geojson
	ogr2ogr -f GeoJSON -sql "SELECT NAME AS name, TYPE AS type, TYPE_ABBR as type_abbr, IUCN as iucn FROM capad_2016_marine WHERE NAME NOT LIKE '%Unnamed%'" data/capad_2016_marine.labelpolygon.geojson data/capad_2016_marine.shp
	geojson-polygon-labels --include-minzoom=0-14 --label polylabel --style combine data/capad_2016_marine.labelpolygon.geojson > data/capad_2016_marine.label.geojson
	rm data/capad_2016_marine.labelpolygon.geojson

geojson:
	ogr2ogr -f GeoJSON -sql "SELECT NAME AS name, TYPE AS type, TYPE_ABBR as type_abbr, IUCN as iucn FROM CAPAD_2016_terrestrial" data/capad_2016_terrestrial.geojson data/CAPAD_2016_terrestrial.shp
	ogr2ogr -f GeoJSON -sql "SELECT NAME AS name, TYPE AS type, TYPE_ABBR as type_abbr, IUCN as iucn FROM capad_2016_marine" data/capad_2016_marine.geojson data/capad_2016_marine.shp

mbtiles:
	tippecanoe -o data/capad_2016.mbtiles --force --name "CAPAD 2016" --read-parallel --named-layer=marine_label:data/capad_2016_marine.label.geojson --named-layer=terrestrial_label:data/capad_2016_terrestrial.label.geojson --named-layer=marine:data/capad_2016_marine.geojson --named-layer=terrestrial:data/capad_2016_terrestrial.geojson --minimum-zoom 0 --extend-zooms-if-still-dropping --maximum-zoom 14 --exclude '_area' --exclude '_minzoom' --drop-smallest-as-needed

clean:
	rm -rf data
