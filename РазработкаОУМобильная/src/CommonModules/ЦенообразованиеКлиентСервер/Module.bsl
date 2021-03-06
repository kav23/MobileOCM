
#Область ПрограммныйИнтерфейс

// Рассчитывает сумму НДС от суммы
//
// Сумма      - Число - Сумма, от которой необходимо рассчитать сумму НДС.
// СтавкаНДС  - Ставка НДС числом
//
Функция РассчитатьСуммуНДС(Сумма, ПроцентНДС) Экспорт
	
	СуммаНДС = Сумма * ПроцентНДС / (ПроцентНДС + 1);
	Возврат СуммаНДС;
	
КонецФункции

#КонецОбласти
