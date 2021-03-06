
#Область ПрограммныйИнтерфейс

Процедура ОтправитьОтчет(ТемаПисьма, ТекстПисьма) Экспорт
	
	Сообщение = Новый ИнтернетПочтовоеСообщение;
	
	Получатели = РаботаСПочтойВызовСервера.ПолучателиОтчетовПоПочте();
	
	Для Каждого Получатель Из Получатели Цикл
		Адрес = Сообщение.Получатели.Добавить(Получатель);
	КонецЦикла;
	
	Текст = Сообщение.Тексты.Добавить(ТекстПисьма);
	Текст.ТипТекста = ТипТекстаПочтовогоСообщения.ПростойТекст;
	Сообщение.Тема = ТемаПисьма;
	
	СредстваПочты.Послать(Сообщение);
	
КонецПроцедуры

#КонецОбласти
