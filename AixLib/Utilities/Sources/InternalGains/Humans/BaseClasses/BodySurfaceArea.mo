within AixLib.Utilities.Sources.InternalGains.Humans.BaseClasses;
function BodySurfaceArea "function for calculating human body surface area"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.Length height "Body height";
  input Modelica.SIunits.Mass weight "Body mass";
  output Modelica.SIunits.Area A "Surface area";

algorithm
  A := 0.202 * weight^0.425*height^0.725 "formula Ruch and Patton (1965)";
  annotation (Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>Function for calculating human body surface area depending on body weight and height.</p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>The body surface area is calculated by the following equation[1]:</p>
<p align=\"center\"><i>A = 0.202&middot;(weight^0.425)&middot;(height^0.725)</i></p>
<p>Average values for the German population (average of male and female) are [2]:</p>
<p>H = 1.72 m</p>
<p>M = 76.3 kg</p>
<p></p>
<table cellspacing=\"2\" cellpadding=\"2\" border=\"1\"><tr>
<td></td>
<td colspan=\"3\"><p align=\"center\"><h4>Average Body Height</h4></p></td>
<td colspan=\"3\"><p align=\"center\"><h4>Average Body Mass</h4></p></td>

</tr>
<tr>
<td></td>
<td colspan=\"3\"><p align=\"center\">m</p></td>
<td colspan=\"3\"><p align=\"center\">kg</p></td>
</tr>
<tr>
<td><p>age</p></td>
<td><p>male</p></td>
<td><p>female</p></td>
<td><p>average</p></td>
<td><p>male</p></td>
<td><p>female</p></td>
<td><p>average</p></td>
</tr>
<tr>
<td><p>18 - 20</p></td>
<td><p>1.81</p></td>
<td><p>1.68</p></td>
<td><p>1.75</p></td>
<td><p>75.7</p></td>
<td><p>60.9</p></td>
<td><p>68.7</p></td>

</tr>
<tr>
<td><p>20 - 25</p></td>
<td><p>1.81</p></td>
<td><p>1.68</p></td>
<td><p>1.75</p></td>
<td><p>78.9</p></td>
<td><p>62.9</p></td>
<td><p>71.4</p></td>

</tr>
<tr>
<td><p>25 - 30</p></td>
<td><p>1.81</p></td>
<td><p>1.67</p></td>
<td><p>1.74</p></td>
<td><p>81.6</p></td>
<td><p>64.7</p></td>
<td><p>73.6</p></td>

</tr>
<tr>
<td><p>30 - 35</p></td>
<td><p>1.80</p></td>
<td><p>1.67</p></td>
<td><p>1.74</p></td>
<td><p>83.7</p></td>
<td><p>66.4</p></td>
<td><p>75.3</p></td>

</tr>
<tr>
<td><p>35 - 40</p></td>
<td><p>1.80</p></td>
<td><p>1.67</p></td>
<td><p>1.74</p></td>
<td><p>85.6</p></td>
<td><p>67.5</p></td>
<td><p>76.8</p></td>

</tr>
<tr>
<td><p>40 - 45</p></td>
<td><p>1.80</p></td>
<td><p>1.67</p></td>
<td><p>1.74</p></td>
<td><p>86.4</p></td>
<td><p>68.1</p></td>
<td><p>77.8</p></td>

</tr>
<tr>
<td><p>45 - 50</p></td>
<td><p>1.80</p></td>
<td><p>1.67</p></td>
<td><p>1.74</p></td>
<td><p>86.6</p></td>
<td><p>68.8</p></td>
<td><p>78.2</p></td>

</tr>
<tr>
<td><p>50 - 55</p></td>
<td><p>1.79</p></td>
<td><p>1.66</p></td>
<td><p>1.73</p></td>
<td><p>86.8</p></td>
<td><p>69.7</p></td>
<td><p>78.6</p></td>

</tr>
<tr>
<td><p>55 - 60</p></td>
<td><p>1.78</p></td>
<td><p>1.65</p></td>
<td><p>1.72</p></td>
<td><p>86.8</p></td>
<td><p>70.4</p></td>
<td><p>78.7</p></td>

</tr>
<tr>
<td><p>60 - 65</p></td>
<td><p>1.77</p></td>
<td><p>1.64</p></td>
<td><p>1.70</p></td>
<td><p>86.6</p></td>
<td><p>71.3</p></td>
<td><p>78.9</p></td>

</tr>
<tr>
<td><p>65 - 70</p></td>
<td><p>1.76</p></td>
<td><p>1.64</p></td>
<td><p>1.70</p></td>
<td><p>85.4</p></td>
<td><p>71.2</p></td>
<td><p>78.1</p></td>

</tr>
<tr>
<td><p>70 - 75</p></td>
<td><p>1.75</p></td>
<td><p>1.64</p></td>
<td><p>1.69</p></td>
<td><p>84.1</p></td>
<td><p>70.8</p></td>
<td><p>77.1</p></td>

</tr>
<tr>
<td><p>75 and over</p></td>
<td><p>1.73</p></td>
<td><p>1.62</p></td>
<td><p>1.67</p></td>
<td><p>80.4</p></td>
<td><p>68.3</p></td>
<td><p>73.3</p></td>

</tr>
<tr>
<td><p>Average</p></td>
<td><p>1.78</p></td>
<td><p>1.65</p></td>
<td><p>1.72</p></td>
<td><p>84.3</p></td>
<td><p>68.4</p></td>
<td><p>76.3</p></td>

</tr>
</table>
<p><br><h4><span style=\"color:#008000\">References</span></h4></p>
<ol>
[1]: Theodore C. Ruch, Harry D. Patton (1965): Physiology and Biophysics. ISBN 9780721678160. </a></li>
<p></p>
[2]: Statistisches Bundesamt: &QUOT;Mikrozensus -- Fragen zur Gesundheit (K&ouml;rperma&szlig;e der Bev&ouml;lkerung)&QUOT;. November 2014. URL: <a href=\"https://www.destatis.de/DE/Publikationen/Thematisch/Gesundheit/Gesundheitszustand/Koerpermasse.html\">https://www.destatis.de/DE/Publikationen/Thematisch/Gesundheit/Gesundheitszustand/Koerpermasse.html</a></li>
</ol>
</html>"));
end BodySurfaceArea;
