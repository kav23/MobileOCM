
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
		//ПараметрыВыполненияКоманды.Источник.Объект.Записать();
		ПараметрыВыполненияКоманды.Источник.Объект.Материалы.Сортировать("ТараНаименование");
		ПараметрыВыполненияКоманды.Источник.Элементы.Материалы.Обновить();
КонецПроцедуры
