import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  //Función que se ejecutará cuando se escriba algo
  final Function(String z) onChanged;
  const SearchBar({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  //La variable para decidir si se muestra o no el campo de búsqueda
  bool showSearchField = false;
  //Color del botón de búsqueda
  final Color searchButtonColor = const Color.fromARGB(255, 91, 171, 236);
  //Color del botón claro
  final Color clearButtonColor = Colors.black;
  Color get primaryColor => const Color.fromARGB(255, 91, 171, 236);
  Color get textColor => Colors.white;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: showSearchField ? Alignment.center : Alignment.centerRight,
      duration: const Duration(seconds: 1),
      padding: EdgeInsets.only(
        top: showSearchField ? 5 : 5,
        bottom: showSearchField ? 30 : 20,
        left: showSearchField ? 12 : 8,
        right: showSearchField ? 12 : 12,
      ),
      child: Material(
        elevation: showSearchField ? 12 : 4,
        shadowColor: primaryColor,
        borderRadius: BorderRadius.circular(360),
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          decoration: BoxDecoration(
            color: showSearchField ? primaryColor : searchButtonColor,
            borderRadius: BorderRadius.circular(360),
          ),
          //Si es [verdadero], muestre [searchField()]; de lo contrario, simplemente muestre el [icono]
          child: showSearchField ? searchBar() : searchButton(),
        ),
      ),
    );
  }

  Widget searchBar() {
    return Row(
      children: [
        if (showSearchField)
          opacity(
            duration: const Duration(seconds: 5),
            child: searchButton(enabled: false),
          ),
        searchField(),
        clearButton(),
      ],
    );
  }

  Widget searchField() {
    return Expanded(
      child: opacity(
        child: TextField(
          autofocus: true,
          onChanged: widget.onChanged,
          style: TextStyle(
            color: textColor,
          ),
          cursorColor: textColor,
          decoration: InputDecoration(
            hintText: 'Buscar',
            hintStyle: TextStyle(
              color: textColor,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  //Botón de búsqueda
  //De forma predeterminada, esto es funcional, pero si necesita deshabilitarlo,
  //Pase el valor como [falsa](femenino)
  Widget searchButton({bool enabled = true}) {
    return IconButton(
      tooltip: enabled ? 'Buscar' : null,
      icon: const Icon(
        Icons.search,
        color: Colors.white,
      ),
      onPressed: enabled == false
          ? null
          : () {
              if (mounted) setState(() => showSearchField = true);
            },
    );
  }

  //Botón Borrar para ocultar la barra de búsqueda
  Widget clearButton() {
    return opacity(
      duration: const Duration(seconds: 4),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: clearButtonColor,
          borderRadius: BorderRadius.circular(360),
        ),
        child: IconButton(
          tooltip: 'Cerrar',
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            if (mounted) setState(() => showSearchField = false);
            //Esto aclarará la consulta
            widget.onChanged('');
            //Si el teclado está abierto, esto lo cerrará automáticamente.
            FocusScope.of(context).unfocus();
          },
        ),
      ),
    );
  }

  //Un widget que muestra  en un período de tiempo específico con duración opcional
  Widget opacity({required Widget child, Duration? duration}) {
    return AnimatedOpacity(
      opacity: showSearchField ? 1 : 0,
      duration: duration ?? const Duration(seconds: 2),
      child: child,
    );
  }
}
