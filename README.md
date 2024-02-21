#NYTimes-App 
Una app para poder ver algunos articulos de The New York Times. 

#Pantallas 
_Log In_
- La app cuenta con un pequeño Log In para iniciar, donde pueden loguearse usando los usuarios:
    U: user1 
    P: password1

    U: user2
    P: password2

    U: user2
    P: password2

  - En esta pantalla, al intentar loguearse con credenciales incorrectas mostrará un error, de la misma manera que al intentar avanzar sin completar los campos de input.

 _Home_
 - En la home hay una navigation bar superior, que tiene un boton de "Back", y el logo del NYTimes.
 - Debajo se observa una Table View dentro de un Scroll View con la lista de artículos disponibles, mostrando su título y fecha de publicación. Las celdas son tapeables.

_Detalle del Artículo_
- Al tapear sobre una celda, el usuario puede entrar al detalle de cada artículo, donde podrá leer además del título y su fecha de publicación, un abstract de la noticia, junto con su autor.
- También tiene una barra de navegación superior igual a la de la home.

#Otros features
_Persistencia de datos:_
- Al momeno de ingresar a cada artículo, estos se guardan para ver sin conexión. Cuando el usuario esté desconectado e intente ver las noticias de la página, la app mostrará un alert informandole que al estar sin conexión, solo puede ver los artículos guardados.
- Luego de cerrar el mensaje, se visualizan estos artículos.

#Arquitectura y Diseño 
- La arquitectura elegida para realizar el proyecto fue VIPER, siendo la arquitectura más cómoda para separar las distintas capas de la aplicación, y manteniendo cada una de ellas con su responsabilidad única, y permitiendo la escalabilidad de forma fácil y efectiva.
- Para la creación de la interfaz de usuario, se utiliza UIKit.

# Dependencias
  · Alamofire
  · AlamofireImage
  · PromiseKit
