
# Astronomy Picture of The Day

It is an app that uses an api provided by NASA to show A Picture of the day.
You can search via a date or you can select the number of pictures for the present day



## API Reference

#### Request

```http
GET https://api.nasa.gov/planetary/apod

```

| Parameter | Type     | Default                | Description|
| :-------- | :------- | :----------------------|------------|
| `date` | `YYYY-MM-DD` | today |The date of the APOD image to retrieve|
|`start_date`|`YYYY-MM-DD`|none|The start of a date range, when requesting date for a range of dates. Cannot be used with `date`.|
|`end_date`|`YYYY-MM-DD`|today|The end of the date range, when used with `start_date`.|
|`count`|`int`|none|If this is specified then count randomly chosen images will be returned. Cannot be used with `date` or `start_date` and `end_date`.|
|`thumbs`|`bool`|False|Return the URL of video thumbnail. If an APOD is not a video, this parameter is ignored.|
|`api_key`|`string`|*DEMO_KEY*|	api.nasa.gov key for expanded usage|






## Screenshots

![](https://user-images.githubusercontent.com/90124241/179388356-05513bc3-c57d-4865-bb3b-015c45a78ac4.jpeg)
![](https://user-images.githubusercontent.com/90124241/179388468-267b1029-140b-44cd-ad2e-fd6684a75848.jpeg)



