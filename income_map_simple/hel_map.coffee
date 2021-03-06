@hel_leaflet_map = (element) ->
    crs_name = 'EPSG:3879'
    proj_def = '+proj=tmerc +lat_0=0 +lon_0=25 +k=1 +x_0=25500000 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs'

    bounds = [25440000, 6630000, 25571072, 6761072]
    crs = new L.Proj.CRS.TMS crs_name, proj_def, bounds,
        resolutions: [256, 128, 64, 32, 16, 8, 4, 2, 1, 0.5, 0.25, 0.125, 0.0625]

    layer_name = "hel:orto2013"
    layer_fmt = "jpg"
    orto_layer = new L.Proj.TileLayer.TMS "http://geoserver.hel.fi/geoserver/gwc/service/tms/1.0.0/#{layer_name}@ETRS-GK25@#{layer_fmt}/{z}/{x}/{y}.#{layer_fmt}", crs,
        maxZoom: 11
        minZoom: 2
        continuousWorld: true
        tms: false

    layer_name = "hel:Opaskartta"
    layer_fmt = "gif"
    map_layer = new L.Proj.TileLayer.TMS "http://geoserver.hel.fi/geoserver/gwc/service/tms/1.0.0/#{layer_name}@ETRS-GK25@#{layer_fmt}/{z}/{x}/{y}.#{layer_fmt}", crs,
        maxZoom: 12
        minZoom: 2
        continuousWorld: true
        tms: false

    map = new L.Map element,
        crs: crs
        continuusWorld: true
        worldCopyJump: false
        zoomControl: true
        layers: [map_layer]
    map.setView [60.171944, 24.941389], 5

    L.control.scale(imperial: false, maxWidth: 200).addTo map

    layer_control = L.control.layers
        'Opaskartta': map_layer
        'Ilmakuva': orto_layer

    return map: map, layer_control: layer_control
