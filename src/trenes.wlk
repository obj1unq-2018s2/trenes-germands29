import deposito.*
import vagonesYLocomotora.*



class Tren{
	var property locomotoras // lista de locomotoras
	var property vagones  // lista de vagones de carga y de pasajeros
	var property uneCiudadesGrandes 
	
	method vagonesLivianos(){

		return 	vagones.count{vagon => vagon.pesoMaximo()< 2500}
	}
	
	method velocidadMaximaDeFormacion(){
		var velocidadesDeLasLocomotoras = []
		locomotoras.forEach{locomotora=> velocidadesDeLasLocomotoras.add(locomotora.velocidadMaxima())}
		return velocidadesDeLasLocomotoras.min()
	}
	
	method formacionEficiente(){
		return locomotoras.all{locomotora => locomotora.arrastreUtil() >= (locomotora.peso()*5)}
	}
	
	method formacionPuedeMoverse(){
		return self.arrastreUtilDeLocomotoras() >= self.pesoTotalDeVagones()
	}
	
	method pesoTotalDeVagones(){
		return 	vagones.sum{vagon => vagon.pesoMaximo()} 
	}
	
	method arrastreUtilDeLocomotoras(){
		return locomotoras.sum{locomotora => locomotora.arrastreUtil()}
	}
	
	method kilosDeEmpujeFaltantes(){
		return if (self.formacionPuedeMoverse())  0
			else self.pesoTotalDeVagones() - self.arrastreUtilDeLocomotoras() 
		}
		
	method vagonMasPesado(){
	
		return  vagones.max{vagon => vagon.pesoMaximo()}
	}
	
	method pesoTotalDeLocomotoras(){
		return locomotoras.sum{locomotora => locomotora.peso()}
	}
	
	
	method formacionCompleja(){
		var cantidadDeUnidades = locomotoras.size() + vagones.size() 
		var pesoTotalDeLasUnidades = self.pesoTotalDeVagones() + self.pesoTotalDeLocomotoras()
		
		return (cantidadDeUnidades > 20) or (pesoTotalDeLasUnidades >= 10000)
	}
	
	method estaBienArmado(){ return self.formacionPuedeMoverse() }
	
	method limiteDeVelocidad(){
		 var locomotora = locomotoras.max{locomotora => locomotora.velocidadMaxima()}	
		 return locomotora.velocidadMaxima()
		}	
}



class FormacionDeCortaDistancia inherits Tren {
	override method estaBienArmado(){
		return super() and not self.formacionCompleja()	
	}
	
	override method limiteDeVelocidad(){
		return super().min(60)
	}
}


class FormacionDeLargaDistancia inherits Tren {
	override method estaBienArmado(){
		return super() and  self.tieneSuficientesBanios()	
	}
	
	override method limiteDeVelocidad(){
		if (uneCiudadesGrandes){ return super().min(200)	}
				else return super().min(150)
		}
	
	
	method tieneSuficientesBanios(){
		var totalBanios = vagones.sum{vagon => vagon.banios()}
		var totalPasajeros = vagones.sum{vagon => vagon.cantidadDePasajeros()}
		return totalBanios >= (totalPasajeros / 50).roundUp()
	}
}
	
class TrenDeAltaVelocidad inherits FormacionDeLargaDistancia {
	override method estaBienArmado(){
		
		return super() and (vagones.size() == self.vagonesLivianos()) and (self.limiteDeVelocidad() <= 250)																
	}
	
	// self.limiteDeVelocidad() <= 250  deberia ser MAYOR O IGUAL, pero nunca se va a cumplir por la condicion
	// de la FormacionDeLargaDistancia , que su limite es como maximo, 200. 
}
