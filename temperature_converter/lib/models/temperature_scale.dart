class TemperatureScale {
    String _name;
    String _symbol;

    TemperatureScale(this._name, this._symbol);

    String get getName {
        return _name;
    }

    String get getSuffix {
        return _symbol;
    }

    set setName(String name) {
        _name = name;
    }

    set setSymbol(String symbol) {
        _symbol = symbol;
    }
}