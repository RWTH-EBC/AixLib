within AixLib.Airflow.AirHandlingUnit.BaseClasses;
expandable connector BusSensors "Bus Connector to Controller for sensor signals"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;

  SI.Temperature T01( min=200, max= 350)
                "Temperature signal from supply air";
  Real T01_RelHum( min=0, max=100)
                "Relative humidity in percent from supply air";
  SI.Temperature T02( min=200, max= 350)
                "Temperature signal from exhaust air inlet";
  Real T02_RelHum( min=0, max=100)
                "Relative humidity in percent from exhaust air inlet";
  SI.Temperature T03( min=200, max= 350)
                "Temperature signal from supply air before steam humidifier";
  Real T03_RelHum( min=0, max=100)
                "Relative humidity in percent from supply air before steam humidifier";
  SI.Temperature T04( min=200, max= 350)
                "Temperature signal from exhaust air inlet";
  Real T04_RelHum( min=0, max=100)
                "Relative humidity in percent from exhaust air inlet";
  SI.Temperature T_Rek( min=200, max= 350)
                "Temperature signal from supply air before recuperator";
  SI.AbsolutePressure P01
                "pressure from supply air before steam humidifier";
  SI.AbsolutePressure P02
                "pressure from exhaust air inlet";
  SI.MassFlowRate mFlowAbs
                "mass flow rate through absorber";
  Real Y02_actual( min=0, max=1)
                "actual value of valve opening Y02";
  Real Y06_actual( min=0, max=1)
                "actual value of valve opening Y06";
  Real Y09_actual( min=0, max=1)
                "actual value of valve opening Y09";

end BusSensors;
