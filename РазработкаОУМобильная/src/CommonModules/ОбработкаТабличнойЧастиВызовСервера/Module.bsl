
#Область ПрограммныйИнтерфейс

Функция НайтиПоШтрихКоду(Штрихкод) Экспорт
	
	//МассивНоменклатуры = Новый Массив;
	//
	//Запрос = Новый Запрос;
	//Запрос.Текст = 
	//"ВЫБРАТЬ
	//|	Штрихкоды.Номенклатура КАК Номенклатура
	//|ИЗ
	//|	РегистрСведений.Штрихкоды КАК Штрихкоды
	//|ГДЕ
	//|	Штрихкоды.Штрихкод = &Штрихкод";
	//
	//Запрос.УстановитьПараметр("Штрихкод", Штрихкод);
	//
	//Результат = Запрос.Выполнить();
	//
	//Выборка = Результат.Выбрать();
	//
	
	//Пока Выборка.Следующий() Цикл
	//	
	//	ДанныеНоменклатуры = ОбработкаТабличнойЧастиТоварыКлиентСервер.ПередаваемыеДанныеНоменклатуры();
	//	
	//	ДанныеНоменклатуры.Номенклатура                    = Выборка.Номенклатура;
	//	ДанныеНоменклатуры.Штрихкод                        = Штрихкод;
	//	ДанныеНоменклатуры.НеобходимостьВводаАкцизнойМарки = ПродажиВызовСервера.ОпределитьНеобходимостьВводаАкцизнойМарки(Выборка.Номенклатура);
	//	
	//	МассивНоменклатуры.Добавить(ДанныеНоменклатуры);
	//	
	//КонецЦикла;
	МассивНоменклатуры = Неопределено;
	
	Возврат МассивНоменклатуры;
	
КонецФункции

Функция НайтиПоШтрихКодуПодобно(Штрихкод) Экспорт
	
	СписокНоменклатуры = Новый СписокЗначений;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Штрихкоды.Номенклатура,
	|	Штрихкоды.Штрихкод
	|ИЗ
	|	РегистрСведений.Штрихкоды КАК Штрихкоды
	|ГДЕ
	|	Штрихкоды.Штрихкод ПОДОБНО &Штрихкод";
	
	Запрос.УстановитьПараметр("Штрихкод", "%" + Штрихкод + "%");
	
	Результат = Запрос.Выполнить();
	
	Если НЕ Результат.Пустой() Тогда
		СписокНоменклатуры = Результат.Выгрузить().ВыгрузитьКолонку("Номенклатура");
	КонецЕсли;
	
	Возврат СписокНоменклатуры;
	
КонецФункции

Функция ОбработатьСтрокуВозвратаПоПродаже(СтруктураДанных) Экспорт
	
	КоэффициентСтроки = Мин(СтруктураДанных.Количество / СтруктураДанных.КоличествоПродажи, 1);
	
	Сумма = СтруктураДанных.Цена * СтруктураДанных.Количество;
	
	СтруктураДанных.СкидкаНаценкаСумма = Окр(СтруктураДанных.СкидкаНаценкаСуммаПродажи * КоэффициентСтроки, 2);
	
	СтруктураДанных.Сумма = Сумма + СтруктураДанных.СкидкаНаценкаСумма;
	
КонецФункции

#КонецОбласти