class Deposito {
	var property formaciones 
	var property locomotoras
	
	method agregarLocomotoraAFormacion(formacion) {
		var locomotora = locomotoras.
		formacion.add(locomotora)
		if(!formacion.formacionPuedeMoverse()){
			var locomotoraApta = self.getLocomotoraApta(formacion)
			formacion.add(locomotoraApta)
		}
	}
	
	method getLocomotoraApta(formacion){
		var locomotorasAptas = locomotoras.filter{locomotora => locomotora.arrastreUtilDeLocomotoras() >= formacion.kilosDeEmpujeFaltantes() }
		return if(!locomotorasAptas.isEmpty()){
			locomotorasAptas.asList().first()
		} else {}
	}

	
	method vagonesMasPesadosDeCadaFormacion(){
		var vagonesMasPesados= #{} 
		formaciones.forEach{tren => vagonesMasPesados.add(tren.vagonMasPesado())}
		
		return vagonesMasPesados
	}
	
	method conductorExperimentado(){
		return formaciones.any{tren=> tren.formacionCompleja()}
	}
	


}

