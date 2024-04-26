Playbook que se encarga de instalar modulos y colecciones desde Git
en versiones de Ansible anteriores a 2.10.

- Variable Info -

{{ repo }}		= Se introduce el url .git del repositorio que queramos clonar.

{{ collection_name }} 	= Se introduce el nombre de la colección, es decir,
			  el directorio donde se encuentre el galaxy.yml y
			  demas contenido del repositorio.

{{ set_module }}	= Si la colección contiene algún módulo que queramos importar
			  tendremos que definir esta variable como Y/y/yes.

{{ module_name }}	= En caso de tener activa la variable {{ set_module }}, aquí
			  habría que introducir el nombre del archivo .py que se 
			  encuentra en el directorio plugins/modules/ de nuestra 
			  colección. (Sin la extensión .py).
