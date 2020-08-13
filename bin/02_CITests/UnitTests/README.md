# What is it?
This templates check, simulate or perform a regression test of AixLib models.

# How to implement?
Add the following lines to your .gitlab-ci.yml:
	
	stages:
		- Check
		- Simulate
		- RegressionTest

	include:
		- project: 'EBC/EBC_all/gitlab_ci/templates'
		- file: 'ci-tests/UnitTests/check_model.gitlab-ci.yml'
		- project: 'EBC/EBC_all/gitlab_ci/templates'
		- file: 'ci-tests/UnitTests/regression_test.gitlac-ci.yml'
		- project: 'EBC/EBC_all/gitlab_ci/templates'
		- file: 'ci-tests/UnitTests/simulate_model.gitlab-ci.yml'	

	

### runUnitTests


For further information on how to use theUnitTest, please refer to the following [link](https://github.com/ibpsa/modelica-ibpsa/wiki/Unit-Tests)

#### To Write a new Unit Test:

This documentation briefly describes how to apply and use the unit tests and how to create reference files that will later be compared for a unit test. 

The documentation already explains how to use a UnitTest and what to consider. A concrete example is given here.

This example uses the AixLib.Airflow.FacadeVentilationUnit.Examples.FacadeVentilationUnit.mo model. 


	within AixLib.Airflow.FacadeVentilationUnit.Examples;
	model FacadeVentilationUnit
	  "Example showing the use of facade ventilation unit and controller"
	  extends Modelica.Icons.Example;

	  package Medium1 = AixLib.Media.Air;
	  package Medium2 = AixLib.Media.Water;

	  AixLib.Controls.AirHandling.FVUController FVUController(
		  maxSupFanPower=0.6,
		  maxExFanPower=0.6)
		"Comprehensive rule-based controller for the facade ventilation unit"
		annotation (Placement(transformation(extent={{-46,-30},{-6,10}})));
	  AixLib.Airflow.FacadeVentilationUnit.FacadeVentilationUnit FVU(redeclare
		  package Air = Medium1, redeclare package Water = Medium2)
		"The facade ventilation unit to be tested in this example"
		annotation (Placement(transformation(extent={{70,-56},{106,-36}})));
	  AixLib.Fluid.Sources.Boundary_pT freshAirSource(
		nPorts=1,
		redeclare package Medium = Medium1,
		use_T_in=true,
		p(displayUnit="Pa") = 101300) "Sink of the exhaust air"
		annotation (Placement(transformation(extent={{6,-84},{26,-64}})));
	  AixLib.Fluid.Sources.Boundary_pT exhaustAirSink(
		nPorts=1,
		redeclare package Medium = Medium1,
		p(displayUnit="Pa") = 101300) "Source of freah air"
		annotation (Placement(transformation(extent={{4,-47},{24,-27}})));
	  AixLib.Fluid.Sources.Boundary_pT heatingSnk(
		redeclare package Medium = Medium2,
		nPorts=1,
		p=100000) "Sink of the heating water" annotation (Placement(transformation(
			extent={{-10,-10},{10,10}},
			rotation=270,
			origin={26,30})));
	  AixLib.Fluid.Sources.Boundary_pT coolingSink(
		redeclare package Medium = Medium2,
		nPorts=1,
		p=100000) "Sink of the cooling water" annotation (Placement(transformation(
			extent={{-10,-10},{10,10}},
			rotation=270,
			origin={102,32})));
	  AixLib.Fluid.Sources.Boundary_pT coolingSource(
		redeclare package Medium = Medium2,
		use_T_in=true,
		nPorts=1,
		p=101000) "Source of the cooling water" annotation (Placement(
			transformation(
			extent={{-10,-10},{10,10}},
			rotation=270,
			origin={126,31})));
	  AixLib.Fluid.Sources.Boundary_pT heatingSource(
		redeclare package Medium = Medium2,
		use_T_in=true,
		nPorts=1,
		p=101000) "Source of the heating water" annotation (Placement(
			transformation(
			extent={{-9,-10},{9,10}},
			rotation=270,
			origin={54,31})));
	  AixLib.Fluid.Sources.Boundary_pT supplyAirSink(
		redeclare package Medium = Medium1,
		use_T_in=false,
		nPorts=1,
		p(displayUnit="Pa") = 101300) "Sink of the supply air" annotation (
		  Placement(transformation(
			extent={{-10,-10},{10,10}},
			rotation=180,
			origin={170,-27})));
	  AixLib.Fluid.Sources.Boundary_pT extractAirSource(
		nPorts=1,
		redeclare package Medium = Medium1,
		use_T_in=true,
		p(displayUnit="Pa") = 101300) "Source of the extract air" annotation (
		  Placement(transformation(
			extent={{-10,-10},{10,10}},
			rotation=180,
			origin={168,-66})));
	  Modelica.Blocks.Sources.Constant heatingWaterTemperature(k=273.15 + 30)
		"Provides a test value of the heating water temperatrure"
		annotation (Placement(transformation(extent={{24,74},{44,94}})));
	  Modelica.Blocks.Sources.Constant coolingWaterTemperature(k=273.15 + 17)
		"Provides a test value of the cooling water temperatiure"
		annotation (Placement(transformation(extent={{84,74},{104,94}})));
	  AixLib.Fluid.Sensors.TemperatureTwoPort supplyAirTemperature(redeclare
		  package Medium = Medium1, m_flow_nominal=0.1)
		"Measures the supply air temperature"
		annotation (Placement(transformation(extent={{120,-54},{140,-34}})));
	  Modelica.Blocks.Sources.Sine roomTemperature(
		amplitude=5,
		freqHz=1/86400,
		phase=3.1415926535898,
		offset=273.15 + 20)
		"Provides a test value of the room temperature"
		annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
	  Modelica.Blocks.Sources.Sine roomSetTemperature(
		amplitude=5,
		freqHz=1/86400,
		phase=1.5707963267949,
		offset=273.15 + 20)
		"Provides a test value of the room set temperature"
		annotation (Placement(transformation(extent={{-100,-36},{-80,-16}})));
	  Modelica.Blocks.Sources.Constant co2Concentration(k=1000)
		"Provides a test value of the CO2 concnetration"
		annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
	  Modelica.Blocks.Sources.Sine outdoorTemperature(
		amplitude=5,
		freqHz=1/86400,
		offset=273.15 + 10) "Provides a test value of the outdoor temperature"
		annotation (Placement(transformation(extent={{-100,6},{-80,26}})));
	  AixLib.Controls.Interfaces.FVUControlBus fVUControlBus
	  "Bus with controller sginals"
	   annotation (Placement(
			transformation(
			extent={{-10,-10},{10,10}},
			rotation=270,
			origin={-26,28})));
	equation
	  connect(FVU.extractAirConnector, extractAirSource.ports[1]) annotation (
	   Line(points={{106.2,-52.8},{148,-52.8},{148,-66},{158,-66}},
		  color={0,127,255},
		  smooth=Smooth.None));
	  connect(heatingSnk.ports[1], FVU.heaterReturnConnector) annotation (Line(
			points={{26,20},{26,-6},{95.2,-6},{95.2,-36}}, color={0,127,255}));
	  connect(coolingSource.ports[1], FVU.coolerFlowConnector) annotation (Line(
			points={{126,21},{126,-26},{105.2,-26},{105.2,-36}},
			color={0,127,255}));
	  connect(heatingWaterTemperature.y, heatingSource.T_in)
		annotation (Line(points={{45,84},{58,84},{58,41.8}}, color={0,0,127}));
	  connect(coolingWaterTemperature.y, coolingSource.T_in) annotation (Line(
			points={{105,84},{105,84},{130,84},{130,43}}, color={0,0,127}));
	  connect(FVU.coolerReturnConnector, coolingSink.ports[1]) annotation (Line(
			points={{102.2,-36},{102,-36},{102,22}}, color={0,127,255}));
	  connect(heatingSource.ports[1], FVU.heaterFlowConnector) annotation (Line(
			points={{54,22},{54,22},{54,10},{98.2,10},{98.2,-36}},
			color={0,127,255}));
	  connect(exhaustAirSink.ports[1], FVU.exhaustAirConnector) annotation (Line(
			points={{24,-37},{42,-37},{42,-43.4},{70,-43.4}}, color={0,127,255}));
	  connect(freshAirSource.ports[1], FVU.freshAirConnector) annotation (Line(
			points={{26,-74},{26,-70},{42,-70},{42,-52.8},{70.2,-52.8}},
			color={0,127,
			  255}));
	  connect(FVU.supplyAirConnector, supplyAirTemperature.port_a) annotation (
	   Line(points={{106.2,-43.4},{106.2,-44},{120,-44}}, color={0,127,255}));
	  connect(supplyAirTemperature.port_b, supplyAirSink.ports[1]) annotation (
	   Line(points={{140,-44},{148,-44},{148,-27},{160,-27}}, color={0,127,255}));
	  connect(FVU.fVUControlBus, FVUController.fVUControlBus) annotation (Line(
		  points={{86,-35.9},{86,-35.9},{86,-12},{86,-10},{86,-8.76923},{-6,
			  -8.76923}},color={255,204,51},thickness=0.5));
	  connect(FVUController.fVUControlBus, fVUControlBus) annotation (Line(
		  points={{-6,-8.76923},{2,-8.76923},{2,28},{-26,28}},
		  color={255,204,51},
		  thickness=0.5), Text(
		  string="%second",
		  index=1,
		  extent={{6,3},{6,3}}));
	  connect(roomTemperature.y, extractAirSource.T_in) annotation (
	   Line(points={{-79,50},{46,50},{192,50},{192,-70},{180,-70}},
	  color={0,0,127}));
	  connect(outdoorTemperature.y,freshAirSource. T_in) annotation (
	   Line(points={{-79,16},{-64,16},{-64,-70},{4,-70}}, color={0,0,127}));
	  connect(roomTemperature.y, fVUControlBus.roomTemperature) annotation (Line(
			points={{-79,50},{-62,50},{-46,50},{-46,27.95},{-25.95,27.95}}, color={0,
			  0,127}), Text(
		  string="%second",
		  index=1,
		  extent={{6,3},{6,3}}));
	  connect(outdoorTemperature.y, fVUControlBus.outdoorTemperature) annotation (
		  Line(points={{-79,16},{-64,16},{-64,27.95},{-25.95,27.95}}, color={0,0,127}),
		  Text(
		  string="%second",
		  index=1,
		  extent={{6,3},{6,3}}));
	  connect(roomSetTemperature.y, fVUControlBus.roomSetTemperature) annotation (
		  Line(points={{-79,-26},{-74,-26},{-74,27.95},{-25.95,27.95}}, color={0,0,127}),
		  Text(
		  string="%second",
		  index=1,
		  extent={{6,3},{6,3}}));
	  connect(co2Concentration.y, fVUControlBus.co2Concentration) annotation (Line(
			points={{-79,-70},{-79,-70},{-74,-70},{-74,27.95},{-25.95,27.95}},
			color={0,0,127}), Text(
		  string="%second",
		  index=1,
		  extent={{6,3},{6,3}}));
	  annotation (
		Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
				100}})),
		Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
				200,100}})),"AixLib.Airflow.FacadeVentilationUnit.Examples.FacadeVentilationUnit
		experiment(Tolerance=1e-6, StopTime=86400),
		__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Airflow/FacadeVentilationUnit/Examples/FacadeVentilationUnit.mos"
						  "Simulate and plot"),
		Documentation(revisions="<html>
	<ul>
	<li>
	July, 2017 by Marc Baranski and Roozbeh Sangi:<br/>
	First implementation.
	</li>
	</ul>
	</html>", info="<html>
	<p>This model demonstrates the usage of the facade ventilation unit connected
	to the standard controller. The inputs are the room and the outdoor temperaure.
	Those temperatures and the room temperature set point are sine waves with a 
	period of one day, which all have a different phase. The simulation result 
	depicted in the following figure shows the behavior of the two-point controller
	that opens the heating valve fully for heating. For cooling, it closes the
	heating valve and bypasses the heat recovery unit so that the supply air
	temperature is equal to the outdoor temperature.</p>
	<p><img src=\"modelica://AixLib/Resources/Images/Airflow/FacadeVentilationUnit/FacadeVentilationUnitExample.png\"
	alt=\"Example result of facade ventilation unit example\"/></p>
	</html>"));
	end FacadeVentilationUnit;

	
It is important that the path is given to the model in the annotation, in which the .mos files are later located.
The important section for this can be seen below

	annotation (
			Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
					100}})),
			Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
					200,100}})),"AixLib.Airflow.FacadeVentilationUnit.Examples.FacadeVentilationUnit
			experiment(Tolerance=1e-6, StopTime=86400),
			__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Airflow/FacadeVentilationUnit/Examples/FacadeVentilationUnit.mos"
							  "Simulate and plot"),
							  
							  
						
A mos file must then be created for this model. 
This can be found under AixLib/Resources/Scripts/Dymola/Airflow/FacadeVentilationUnit/Examples/FacadeVentilationUnit.mos

It must be considered beforehand which variables are to be compared later, and is therefore especially important for the modelers of their own model.

This mos file looks like the following

	simulateModel("AixLib.Airflow.FacadeVentilationUnit.Examples.FacadeVentilationUnit", stopTime=3600,outputInterval=60,
	 method="lsodar", tolerance=1e-06, resultFile="FacadeVentilationUnit");
	createPlot(id = 1,
	 position = {35, 30, 825, 625},
	 y = {"FVUController.roomToBeCooled.reference","FVUController.roomToBeHeated.reference"},
	 range = {0, 3600.0, 3.5, (-1.5)},
	 grid=true,
	 filename = "FacadeVentilationUnit.mat",
	 colors={{28,108,200},{238,46,47}});

	 
	 
Then the unit test is executed with the following command

```shell
	python ../bin/runUnitTests.py -n 2 --single-package AixLib.Airflow --tool dymola
```

You will be asked if the user wants to have a reference file created and saved.
The reference file then looks like the one below and can be compared and used in future UnitTests. The reference file is saved as text file under the path AixLib/Resources/ReferenceResults/Dymola/AixLib_Airflow_FacadeVentilationUnit_Examples_FacadeVentilationUnit.txt 

```shell
	last-generated=2019-03-28
	statistics-initialization=
	{
	  "nonlinear": "2, 1, 1, 1, 0",
	  "numerical Jacobians": "0"
	}
	statistics-simulation=
	{
	  "linear": "0, 0",
	  "nonlinear": "2, 0, 1, 1, 0",
	  "number of continuous time states": "25",
	  "numerical Jacobians": "0"
	}
	FVUController.roomToBeHeated.reference=[2.981499938964844e+02, 2.9814013671875e+02, 2.981105651855469e+02, 2.980614318847656e+02, 2.97992919921875e+02, 2.979052734375e+02, 2.977988891601562e+02, 2.976741333007812e+02, 2.975315246582031e+02, 2.973716430664062e+02, 2.971950988769531e+02, 2.970025634765625e+02, 2.967948303222656e+02, 2.965727233886719e+02, 2.963371276855469e+02, 2.960889282226562e+02, 2.958291320800781e+02, 2.955587768554688e+02, 2.952789001464844e+02, 2.949906311035156e+02, 2.946950988769531e+02, 2.943934631347656e+02, 2.940869140625e+02, 2.937766723632812e+02, 2.934639587402344e+02, 2.931499938964844e+02, 2.928360595703125e+02, 2.925233459472656e+02, 2.922131042480469e+02, 2.919065551757812e+02, 2.916049194335938e+02, 2.913093872070312e+02, 2.910211181640625e+02, 2.907412414550781e+02, 2.904708557128906e+02, 2.902110595703125e+02, 2.89962890625e+02, 2.897272644042969e+02, 2.895051574707031e+02, 2.892974243164062e+02, 2.891049194335938e+02, 2.889283752441406e+02, 2.887684631347656e+02, 2.886258544921875e+02, 2.885011291503906e+02, 2.883947143554688e+02, 2.883070983886719e+02, 2.882385559082031e+02, 2.881894226074219e+02, 2.881598815917969e+02, 2.881499938964844e+02, 2.881598815917969e+02, 2.881894226074219e+02, 2.882385559082031e+02, 2.883070983886719e+02, 2.883947143554688e+02, 2.885011291503906e+02, 2.886258544921875e+02, 2.887684631347656e+02, 2.889283752441406e+02, 2.891049194335938e+02, 2.892974243164062e+02, 2.895051574707031e+02, 2.897272644042969e+02, 2.89962890625e+02, 2.902110595703125e+02, 2.904708557128906e+02, 2.907412414550781e+02, 2.910211181640625e+02, 2.913093872070312e+02, 2.916049194335938e+02, 2.919065551757812e+02, 2.922131042480469e+02, 2.925233459472656e+02, 2.928360595703125e+02, 2.931499938964844e+02, 2.934639587402344e+02, 2.937766723632812e+02, 2.940869140625e+02, 2.943934631347656e+02, 2.946950988769531e+02, 2.949906311035156e+02, 2.952789001464844e+02, 2.955587768554688e+02, 2.958291320800781e+02, 2.960889282226562e+02, 2.963371276855469e+02, 2.965727233886719e+02, 2.967948303222656e+02, 2.970025634765625e+02, 2.971950988769531e+02, 2.973716430664062e+02, 2.975315246582031e+02, 2.976741333007812e+02, 2.977988891601562e+02, 2.979052734375e+02, 2.97992919921875e+02, 2.980614318847656e+02, 2.981105651855469e+02, 2.9814013671875e+02, 2.981499938964844e+02]
	FVUController.roomToBeCooled.reference=[2.931499938964844e+02, 2.928360595703125e+02, 2.925233459472656e+02, 2.922131042480469e+02, 2.919065551757812e+02, 2.916049194335938e+02, 2.913093872070312e+02, 2.910211181640625e+02, 2.907412414550781e+02, 2.904708557128906e+02, 2.902110595703125e+02, 2.89962890625e+02, 2.897272644042969e+02, 2.895051574707031e+02, 2.892974243164062e+02, 2.891049194335938e+02, 2.889283752441406e+02, 2.887684631347656e+02, 2.886258544921875e+02, 2.885011291503906e+02, 2.883947143554688e+02, 2.883070983886719e+02, 2.882385559082031e+02, 2.881894226074219e+02, 2.881598815917969e+02, 2.881499938964844e+02, 2.881598815917969e+02, 2.881894226074219e+02, 2.882385559082031e+02, 2.883070983886719e+02, 2.883947143554688e+02, 2.885011291503906e+02, 2.886258544921875e+02, 2.887684631347656e+02, 2.889283752441406e+02, 2.891049194335938e+02, 2.892974243164062e+02, 2.895051574707031e+02, 2.897272644042969e+02, 2.89962890625e+02, 2.902110595703125e+02, 2.904708557128906e+02, 2.907412414550781e+02, 2.910211181640625e+02, 2.913093872070312e+02, 2.916049194335938e+02, 2.919065551757812e+02, 2.922131042480469e+02, 2.925233459472656e+02, 2.928360595703125e+02, 2.931499938964844e+02, 2.934639587402344e+02, 2.937766723632812e+02, 2.940869140625e+02, 2.943934631347656e+02, 2.946950988769531e+02, 2.949906311035156e+02, 2.952789001464844e+02, 2.955587768554688e+02, 2.958291320800781e+02, 2.960889282226562e+02, 2.963371276855469e+02, 2.965727233886719e+02, 2.967948303222656e+02, 2.970025634765625e+02, 2.971950988769531e+02, 2.973716430664062e+02, 2.975315246582031e+02, 2.976741333007812e+02, 2.977988891601562e+02, 2.979052734375e+02, 2.97992919921875e+02, 2.980614318847656e+02, 2.981105651855469e+02, 2.9814013671875e+02, 2.981499938964844e+02, 2.9814013671875e+02, 2.981105651855469e+02, 2.980614318847656e+02, 2.97992919921875e+02, 2.979052734375e+02, 2.977988891601562e+02, 2.976741333007812e+02, 2.975315246582031e+02, 2.973716430664062e+02, 2.971950988769531e+02, 2.970025634765625e+02, 2.967948303222656e+02, 2.965727233886719e+02, 2.963371276855469e+02, 2.960889282226562e+02, 2.958291320800781e+02, 2.955587768554688e+02, 2.952789001464844e+02, 2.949906311035156e+02, 2.946950988769531e+02, 2.943934631347656e+02, 2.940869140625e+02, 2.937766723632812e+02, 2.934639587402344e+02, 2.931499938964844e+02]
	time=[0e+00, 8.64e+04]
```
### validatetest
	
This test check and simulate the models. You have following options:
	
	check_test_group = parser.add_argument_group("arguments to run check tests")
	check_test_group.add_argument("-b", "--batch", action ="store_true", help="Run in batch mode without user Interaction")
	check_test_group.add_argument("-t", "--tool", metavar="dymola",default="dymola", help="Tool for the Checking Tests. Set to Dymola")
	check_test_group.add_argument('-s',"--single-package",metavar="AixLib.Package", help="Test only the Modelica package AixLib.Package")
	check_test_group.add_argument("-p","--path", default=".", help = "Path where top-level package.mo of the library is located")
	check_test_group.add_argument("-n", "--number-of-processors", type=int, default= multiprocessing.cpu_count(), help="Maximum number of processors to be used")
	check_test_group.add_argument("--show-gui", help="show the GUI of the simulator" , action="store_true")
	check_test_group.add_argument("-WL", "--WhiteList", help="Create a WhiteList of IBPSA Library: y: Create WhiteList, n: Don´t create WhiteList" , action="store_true")
	check_test_group.add_argument("-SE", "--SimulateExamples", help="Check and Simulate Examples in the Package" , action="store_true")
	check_test_group.add_argument("-DS", "--DymolaVersion",default="2020", help="Version of Dymola(Give the number e.g. 2020")
	
	1.	--WhiteList
	
Clone the repository of IBPSA and check the models. Models that failed will append to the Whitelist. These models will not checked.

	2. --SimulateExamples

Example:

	- python bin/02_CITests/UnitTests/CheckPackages/validatetest.py -s "AixLib.Airflow" -p AixLib/package.mo --SimulateExamples


The Test will check and simulate all examples and validation in AixLib. 
	
# What is done?
- Simulate models
- check models
- Write a Whitelist of failing IBPSA models
- regression test of models