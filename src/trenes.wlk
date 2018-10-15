class Tren{
	var property locomotoras // lista de locomotoras
	var property vagonesDeCarga //lista de vagones de carga
	var property vagonesDePasajeros //lista de vagones de pasajeros

	method vagonesLivianos(){

	return 		vagonesDePasajeros.count{vagon => vagon.pesoMaximo()<2500} +
				vagonesDeCarga.count {vagon => vagon.pesoMaximo() < 2500}
		
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
		return 	vagonesDeCarga.sum{vagon => vagon.pesoMaximo()} +
				vagonesDePasajeros.sum{vagon => vagon.pesoMaximo()}
	}
	
	method arrastreUtilDeLocomotoras(){
		return locomotoras.sum{locomotora => locomotora.arrastreUtil()}
	}
	
	method kilosDeEmpujeFaltantes(){
		return if (self.formacionPuedeMoverse())  0
			else self.pesoTotalDeVagones() - self.arrastreUtilDeLocomotoras() 
		}
		
	method vagonMasPesado(){
	
		var vagonDePasajeroMasPesado = if (!vagonesDePasajeros.isEmpty())
										{ return vagonesDePasajeros.max{vagon => vagon.pesoMaximo()}}
										else #{}
										
		
		var vagonDeCargaMasPesado = if (!vagonesDeCarga.isEmpty())
									{ return vagonesDeCarga.max{vagon => vagon.pesoMaximo()}}
									else #{}
									
		 if (vagonDePasajeroMasPesado.pesoMaximo() >= vagonDeCargaMasPesado.pesoMaximo())
		 			return vagonDePasajeroMasPesado
		 else 		return vagonDeCargaMasPesado
	}
	
	method pesoTotalDeLocomotoras(){
		return locomotoras.sum{locomotora => locomotora.peso()}
	}
	
	
	method formacionCompleja(){
		var cantidadDeUnidades = locomotoras.size() + vagonesDePasajeros.size() + vagonesDeCarga.size()
		var pesoTotalDeLasUnidades = self.pesoTotalDeVagones() + self.pesoTotalDeLocomotoras()
		
		return (cantidadDeUnidades > 20) or (pesoTotalDeLasUnidades >= 10000)
	}
}
	


class Deposito {
	var property formaciones 
	var locomotoras
	
//	method agregarLocomotoraAFormacion(locomotora) = formaciones.add(locomotora)
	
	method vagonesMasPesadosDeCadaFormacion(){
		var vagonesMasPesados= #{} 
		formaciones.forEach{tren => vagonesMasPesados.add(tren.vagonMasPesado())}
		
		return vagonesMasPesados
	}
	
	method conductorExperimentado(){
		return formaciones.any{tren=> tren.formacionCompleja()}
	}
	
}

class VagonDePasajero{
	var property largo
	var property ancho
	
	method cantidadDePasajeros(){
		if (ancho <= 2.5) return largo * 8
		else return largo* 10  
	}
	method pesoMaximo() = self.cantidadDePasajeros()*80
}


class VagonDeCarga{
	var property cargaMaxima 
	method pesoMaximo() = cargaMaxima + 160
}

class Locomotora {
	var property peso 
	var property pesoMaximoQuePuedeArrastrar 
	var property velocidadMaxima
	method arrastreUtil()= pesoMaximoQuePuedeArrastrar - peso
}


