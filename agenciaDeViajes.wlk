
class Beneficio {
    const tipo //= ["traslado privado", "acceso a salas vip", "seguro adicionales"]
    var costo 
    var estaVigente = true
}

class Pack {
    var duracionDias
    var precioBase
    const beneficiosEspeciales = []
    var coordinador

    method agregarBeneficio(nuevoBeneficio) = beneficiosEspeciales.add(nuevoBeneficio)

    method beneficioVigente() = beneficiosEspeciales.filter({b => b.estaVigente()})
    method costoBeneficioVigente() = self.beneficioVigente().sum({b=> b.costo()})

    method valorFinal() = precioBase + self.costoBeneficioVigente()

    method esPremium 

}
class PackNacional inherits Pack {
    var provinciaDestino
    const actividadesIncluidas = []
    
    method agregarActividad(actividad) = actividadesIncluidas.add(actividad)
    method provinciaDestino() = provinciaDestino
    override method esPremium() = (duracionDias > 10) && coordinador.altamenteCalificado()
    method cantActividades() = actividadesIncluidas.size() 

}

class PackProvincial inherits PackNacional {
    var cantCiudadesAVisitar

    override method esPremium() = (self.cantActividades() >= 4) && (cantCiudadesAVisitar > 5) && (self.beneficioVigente().size() >= 3)

    override method valorFinal() = if (self.esPremium()) super() * 1.05 else super()



}



class PackInternacional inherits Pack {
    var paisDestino
    var lugarDeInteres
    var cantEscalas


    method paisDestino() = paisDestino
    method cantEscalas() = cantEscalas
    override method valorFinal() = super() * 1.20

    override method esPremium() = lugarDeInteres && (duracionDias > 20) && (cantEscalas == 0)
    
}


class Coordinador {
  var cantViajes
  var estaMotivado
  var aniosExp
  var rol

  const rolesValidos = ["guia", "asistente logistico", "acompañante"]

  method cambiarRol(rolNuevo) {
    if (!rolesValidos.contains(rolNuevo)) {
      self.error("El rol no existe")
    }
    rol = rolNuevo
  }
  
  method cumpleCondicionRol() =
    if (rol == "guia") estaMotivado
    else if(rol == "asistente logistico") aniosExp >= 3
    else true
    
  

  method altamenteCalificado() = cantViajes > 20 && self.cumpleCondicionRol()

}
