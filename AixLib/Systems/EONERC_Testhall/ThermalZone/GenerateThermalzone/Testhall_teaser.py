def example_create_building():
    """"This function demonstrates generating a building adding all
    information separately"""

    # First step: Import the TEASER API (called Project) into your Python module

    from teaser.project import Project

    # To use the API instantiate the Project class and rename the Project. The
    # parameter load_data=True indicates that we load data into our
    # Project (e.g. for Material properties and typical wall constructions.
    # This can take a few seconds, depending on the size of the used data base.

    prj = Project(load_data=True)
    prj.name = "Testhall"

    # Instantiate a Building class and set the Project API as a parent to
    # this building. This will automatically add this building and all its
    # future changes to the project. This is helpful as we can use the data
    # base and API functions (like explained in e2 - e5). We also set some
    # building parameters. Be careful: Dymola does not like whitespaces in
    # names and filenames, thus we will delete them anyway in TEASER.

    from teaser.logic.buildingobjects.building import Building

    bldg = Building(parent=prj)
    bldg.name = "EON_ERC_Testhall"
    bldg.street_name = "Mathieustraße10"
    bldg.city = "Aachen"
    bldg.year_of_construction = 2015  # TODO: check! If default values of load_type_element() are used, year_of_construction can't be lower than 2015
    bldg.number_of_floors = 1
    bldg.height_of_floors = 7.47  # Average of Floors

    # Instantiate a ThermalZone class and set the Building as a parent of it.
    # Set some parameters of the thermal zone. Be careful: Dymola does not
    # like whitespaces in  names and filenames, thus we will delete them
    # anyway in TEASER.

    from teaser.logic.buildingobjects.thermalzone import ThermalZone

    tz = ThermalZone(parent=bldg)
    tz.name = "Hall1"
    tz.area = 779.7
    tz.volume = tz.area * bldg.number_of_floors * bldg.height_of_floors
    #tz.volume = 5825.8
    #tz.area = tz.volume / (bldg.number_of_floors * bldg.height_of_floors)
    tz.infiltration_rate = 0.5 # TODO: check

    # Instantiate BoundaryConditions and load conditions for `Living`.

    from teaser.logic.buildingobjects.useconditions \
        import UseConditions

    tz.use_conditions = UseConditions(parent=tz)
    tz.use_conditions.load_use_conditions("Commercial and industrial Halls - medium work, standing activity", prj.data) # TODO: check

    # Define two building elements reflecting a pitched roof (south = 180° and
    # north = 0°). Setting the ThermalZone as a parent will automatically
    # assign this element to the thermal zone. We also set names, tilt and
    # coefficients for heat transfer on the inner and outer side of the
    # roofs. If the building has a flat roof, please use -1 as
    # orientation. Please read the docs to get more information on these
    # parameters.

    from teaser.logic.buildingobjects.buildingphysics.rooftop import Rooftop

    roof= Rooftop(parent=tz)
    roof.name = "Roof"
    roof.area = 711
    roof.orientation = -1
    roof.tilt = 0

    # TODO: use default values?
    roof.inner_convection = 1.7
    roof.outer_convection = 20.0
    roof.inner_radiation = 5.0
    roof.outer_radiation = 5.0

    # To define the wall constructions we need to instantiate Layer and
    # Material objects and set attributes. id indicates the order of wall
    # construction from inside to outside (so 0 is on the inner surface). You
    # need to set this value!

    from teaser.logic.buildingobjects.buildingphysics.layer import Layer
    from teaser.logic.buildingobjects.buildingphysics.material import Material

    layer_s1 = Layer(parent=roof, id=0)
    layer_s1.thickness = 0.003  # m

    material_s1 = Material(layer_s1)
    material_s1.name = "Kunststoff-Dachbahn"
    material_s1.density = 700
    material_s1.heat_capac = 1.2 # TODO: check! Approximated by heat capacity of Polycarbonat
    material_s1.thermal_conduc = 0.2

    layer_s2 = Layer(parent=roof, id=1)
    layer_s2.thickness = 0.16 #m

    material_s2 = Material(layer_s2)
    material_s2.name = "Polystyrol"
    material_s2.density = 30
    material_s2.heat_capac = 1.5 # TODO: check! Approximated from: https://www.energie-experten.org/bauen-und-sanieren/daemmung/daemmstoffe/polystyrol
    material_s2.thermal_conduc = 0.035

    layer_s3 = Layer(parent=roof, id=2)
    layer_s3.thickness = 0.00025  # m

    material_s3 = Material(layer_s3)
    material_s3.name = "Polyethylenfolie"
    material_s3.density = 960
    material_s3.heat_capac = 1.9 # TODO: check! Approximated by heat capacity of Polyethylen
    material_s3.thermal_conduc = 0.33

    layer_s4 = Layer(parent=roof, id=3)
    layer_s4.thickness = 0.035  # m

    material_s4 = Material(layer_s4)
    material_s4.name = "Deckung: Trapezblech"
    material_s4.density = 7000  # TODO: check! Approximated by density of steel (not sure about that)
    material_s4.heat_capac = 0.46 # TODO: check! Approximated by heat capacity of steel (not sure about that)
    material_s4.thermal_conduc = 1000 # TODO: check! Is this a correct value?

    # Another option is to use the database for typical wall constructions,
    # but set area, tilt, orientation individually. To simplify code,
    # we save individual information for exterior walls, interior walls into
    # dictionaries.
    # outer walls
    # {'name_of_wall': [area, tilt, orientation]}

    from teaser.logic.buildingobjects.buildingphysics.outerwall import OuterWall

    out_wall_dict = {"OuterWall_south_east": [389.64, 90.0, 135.0],
                     "OuterWall_north_west": [389.64, 90.0, 315.0],
                     "OuterWall_south_west": [95.91, 90.0, 225.0]
                     }

    # TODO: 4th Outer wall needed?
    # "OuterWall_north_east": [95.91, 90.0, 45.0]

    for key, value in out_wall_dict.items():
        # Instantiate class, key is the name
        out_wall = OuterWall(parent=tz)
        out_wall.name = key
        # Use load_type_element() function of the building element, and pass
        # over the year of construction of the building and the type of
        # construction (in this case `heavy`).

        out_wall.load_type_element(
            year=bldg.year_of_construction,
            construction='heavy')   # TODO: check 'heavy' or 'light'

        # area, tilt and orientation need to be set individually.

        out_wall.area = value[0]
        out_wall.tilt = value[1]
        out_wall.orientation = value[2]

        # TODO: Add information of layer and material? (Not includes in example script) - perhaps load_type_element() is the alternative (same for IntWall, GroundFloor)
        # layer_sx = Layer(parent=out_wall, id=x)
        # material_sx = Material(layer_sx)


    ground_floor_dict = {"GroundFloor": [629, 0.0, -2]}

    from teaser.logic.buildingobjects.buildingphysics.groundfloor import \
        GroundFloor

    for key, value in ground_floor_dict.items():

        ground = GroundFloor(parent=tz)
        ground.name = key
        ground.load_type_element(
            year=bldg.year_of_construction,
            construction='heavy')   # TODO: check 'heavy' or 'light'

        ground.area = value[0]
        ground.tilt = value[1]
        ground.orientation = value[2]

    # interior walls
    # TODO: without orientation?

    from teaser.logic.buildingobjects.buildingphysics.innerwall import InnerWall

    in_wall_dict = {"InnerWall_north_east": [152.66, 90.0],
                    "InnerWall_south_west": [56.75, 90.0],
                    "InnerWall_sec_ground_floor": [150.7, 0]}


    for key, value in in_wall_dict.items():

        in_wall = InnerWall(parent=tz)
        in_wall.name = key
        in_wall.load_type_element(
            year=bldg.year_of_construction,
            construction='light') # TODO: check 'heavy' or 'light'

        in_wall.area = value[0]
        in_wall.tilt = value[1]
        # in_wall.orientation = value[2]

    return prj


if __name__ == '__main__':
    example_create_building()
