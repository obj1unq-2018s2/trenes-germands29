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
	
	method cantidadDePasajeros() = 0
	
	method pesoMaximo() = cargaMaxima + 160
}

class Locomotora {
	var property peso 
	var property pesoMaximoQuePuedeArrastrar 
	var property velocidadMaxima
	method arrastreUtil()= self.pesoMaximoQuePuedeArrastrar() - self.peso()
}