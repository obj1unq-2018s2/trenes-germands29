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
		 return locomotoras.max{locomotora => locomotora.velocidadMaxima()}	
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
		if (uneCiudadesGrandes){ return 200	}
				else return 150
		}
	
	
	method tieneSuficientesBanios(){
		var totalBanios = vagones.sum{vagon => vagon.banios()}
		var totalPasajeros = vagones.sum{vagon => vagon.cantidadDePasajeros()}
		return totalBanios >= (totalPasajeros / 50).roundUp()
	}
}
