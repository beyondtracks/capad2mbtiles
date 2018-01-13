# capad2mbtiles

capad2mbtiles is a utility to convert the Australian [Collaborative Australian Protected Areas Database (CAPAD)](http://www.environment.gov.au/land/nrs/science/capad) into an MBTiles for cartographic purposes and easier use with Mapbox maps.

It is used by [beyondtracks.com](https://www.beyondtracks.com) to display protected area boundaries on the map.

# Download pre-built

You can download the pre-built cartographic [capad_2016.mbtiles](https://www.beyondtracks.com/contrib/capad_2016.mbtiles).

# Building from source

Unfortunately the download sites are a pain to use as they use JavaScript to construct a big HTTP POST request for the data. This makes it hard to script a remote headless server to download the data. In the meantime manually download the data to the data directory from:

- http://www.environment.gov.au/fed/catalog/search/resource/downloadData.page?uuid=%7B4448CACD-9DA8-43D1-A48F-48149FD5FCFD%7D
- http://www.environment.gov.au/fed/catalog/search/resource/downloadData.page?uuid=%7BAF4EE98E-7F09-4172-B95E-067AB8FA10FC%7D

Ensure you have installed [tippecanoe](https://github.com/mapbox/tippecanoe), [geojson-polygon-labels](https://github.com/andrewharvey/geojson-polygon-labels) and gdal-bin (ogr2ogr).

Then run:

    make unzip labels geojson mbtiles

# Credits

_[Collaborative Australian Protected Areas Database (CAPAD) 2016](http://www.environment.gov.au/land/nrs/science/capad), Commonwealth of Australia 2017. Licensed under the [Creative Commons Attribution 3.0 Australia License](http://creativecommons.org/licenses/by/3.0/au/deed.en)._
