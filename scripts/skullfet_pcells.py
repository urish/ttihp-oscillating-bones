import pya
import math

class SkullFETRing(pya.PCellDeclarationHelper):
  """
  The PCell declaration for the SkullFET ring
  """

  def __init__(self):

    # Important: initialize the super class
    super(SkullFETRing, self).__init__()

    # declare the parameters
    self.param("n", self.TypeInt, "Count", default = 21)
    self.param("r", self.TypeDouble, "Radius", default = 100)
    self.param("rd", self.TypeDouble, "Double radius", readonly = True)

  def display_text_impl(self):
    # Provide a descriptive text for the cell
    return "SkullFETRing(n=" + str(self.n) + ",R=" + ('%.3f' % self.r) + ")"
  
  def coerce_parameters_impl(self):
    self.rd = 2*self.r
    if self.n <= 4:
      self.n = 4

  def produce_impl(self):
    target = self.layout.create_cell("unit_cell")
    da = math.pi * 2 / self.n
    for i in range(0, self.n):
      x = self.r * math.cos(i * da)
      y = self.r * math.sin(i * da)
      # Snap x/y to 0.005 grid:
      x = round(x * 200) / 200
      y = round(y * 200) / 200
      dtrans = pya.DTrans(pya.DTrans.R0, pya.DPoint(x, y))
      inst = pya.DCellInstArray(target, dtrans)
      self.cell.insert(inst)


class PowerRing(pya.PCellDeclarationHelper):
  def __init__(self):
    super(PowerRing, self).__init__()
    self.param("l", self.TypeLayer, "Layer")
    self.param("thickness", self.TypeDouble, "Thickness", default = 10)
    self.param("r", self.TypeDouble, "Radius", default = 100)
    self.param("steps", self.TypeInt, "Steps", default = 360)
    self.param("rd", self.TypeDouble, "Double radius", readonly = True)
  
  def display_text_impl(self):
    return "PowerRing(R=" + ('%.3f' % self.r) + ")"
  
  def coerce_parameters_impl(self):
    self.rd = 2*self.r
  
  def produce_impl(self):
    steps = self.steps
    r = self.r
    thickness = self.thickness
    for i in range(steps):
      x = r * math.cos(2 * math.pi * i / steps)
      y = r * math.sin(2 * math.pi * i / steps)
      # align to 0.005um grid
      x = round(x*200)/200
      y = round(y*200)/200
      rect = pya.DBox(pya.DPoint(x-thickness/2, y-thickness/2), pya.DPoint(x+thickness/2, y+thickness/2))
      self.cell.shapes(self.l_layer).insert(rect)
  

class SkullFETLib(pya.Library):

  def __init__(self):
  
    # Set the description
    self.description = "SkullFET Library"
    
    # Create the PCell declarations
    self.layout().register_pcell("SkullFETRing", SkullFETRing())
    self.layout().register_pcell("PowerRing", PowerRing())
    # That would be the place to put in more PCells ...
    
    # Register us with the name "MyLib".
    # If a library with that name already existed, it will be replaced then.
    self.register("SkullFET")


# Instantiate and register the library
SkullFETLib()
