
Функция ОпределитьЭтаИнформационнаяБазаФайловая(СтрокаСоединенияСБД = "") Экспорт
	#Если  МобильноеПриложениеКлиент  тогда
	Возврат Ложь
	#Иначе
	СтрокаСоединенияСБД = ?(ПустаяСтрока(СтрокаСоединенияСБД), СтрокаСоединенияИнформационнойБазы(), СтрокаСоединенияСБД);
	
	// в зависимости от того файловый это вариант БД или нет немного по-разному путь в БД формируется
	ПозицияПоиска = Найти(Врег(СтрокаСоединенияСБД), "FILE=");
	
	Возврат ПозицияПоиска = 1;	
	
#КонецЕсли

КонецФункции

// Функция предназначена для получения значения по имени переменной
// значения берутся либо из КЭШа конфигурации (параметр сеанса "ОбщиеЗначения"),
// либо при помощи механизма платформы "повторное использование возвращаемых значений"
//
// Параметры:
//	ИмяПеременной - Строка, имя переменной
//
// Возвращаемое значение: 
//  Произвольное значение
//
Функция глЗначениеПеременной(ИмяПеременной) Экспорт
	
	Возврат РаботаСОбщимиПеременными.ПолучитьЗначениеПеременной(ИмяПеременной);
	
КонецФункции

// Процедура установки значения экспортных переменных модуля приложения
//
// Параметры
//  ИмяПеременной      - строка, содержит имя переменной целиком
// 	ЗначениеПеременной - значение переменной
//
Процедура глЗначениеПеременнойУстановить(ИмяПеременной, ЗначениеПеременной, ОбновитьКэшНаСервере = Ложь) Экспорт
	
	РаботаСОбщимиПеременными.УстановитьЗначениеПеременной(ИмяПеременной, ЗначениеПеременной, ОбновитьКэшНаСервере);
	
КонецПроцедуры

// УГМК++ Пресников Ю.В.
Функция Pi() Экспорт
	Возврат( 3.1415926535897932);
КонецФункции
// УГМК-- Пресников Ю.В.
