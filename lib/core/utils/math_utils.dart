/// Calcula el porcentaje ahorrado en relación a una meta.
/// Retorna 0 si la meta es 0 para evitar división por cero.
double calculatePercentageSavings(double cantidad, double meta) {
  if (meta == 0) return 0;
  return (cantidad / meta) * 100;
}

/// Calcula cuánto debes ahorrar por día para alcanzar una meta en X días.
/// Retorna 0 si days es 0.
double calculateDailySavings(double goal, int days) {
  if (days <= 0) return 0;
  return goal / days;
}

/// Calcula el promedio de una lista de valores.
/// Retorna 0 si la lista está vacía.
double calculateAverage(List<double> values) {
  if (values.isEmpty) return 0.0;
  double sum = 0.0;
  for (final value in values) {
    sum += value;
  }
  return sum / values.length;
}
