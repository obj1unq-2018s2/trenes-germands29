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

