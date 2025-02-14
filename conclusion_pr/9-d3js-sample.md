# D3.js

D3.js (اسناد مبتنی بر داده) یک کتابخانه قدرتمند جاوا اسکریپت است که برای ایجاد تجسم‌های داده‌ای پویا و تعاملی در مرورگرهای وب استفاده می‌شود. این به توسعه‌دهندگان اجازه می‌دهد تا داده‌ها را به عناصر HTML متصل کنند، که سپس می‌توان بر اساس آن داده‌ها، آن‌ها را دستکاری کرد. D3.js امکان ایجاد تجسم‌های پیچیده مانند نمودارها، نقشه‌ها و انیمیشن‌ها را فراهم می‌کند و آن را به طور گسترده برای تجسم داده‌ها در برنامه‌های وب مورد استفاده قرار می‌دهد.

برخی از ویژگی‌های کلیدی D3.js عبارتند از:

- **اتصال داده**: D3 به شما امکان می‌دهد داده‌ها را به عناصر DOM متصل کنید، و ایجاد و به‌روزرسانی تجسم‌ها را به صورت پویا بر اساس تغییر داده‌ها آسان می‌کند.
- **رندر SVG و Canvas**: از SVG (گرافیک برداری مقیاس‌پذیر) و Canvas برای رندر عناصر گرافیکی استفاده می‌کند و به شما کنترل کاملی بر طراحی و استایل می‌دهد.
- **تعامل**: D3.js از ایجاد تجسم‌های تعاملی، مانند تولتیپ‌ها، جلوه‌های هاور و رویدادهای کلیک پشتیبانی می‌کند.
- **انیمیشن‌ها**: انیمیشن‌های روان را برای انتقال بین حالات داده ارائه می‌دهد، و امکان تجسم‌های جذاب‌تر و آموزنده‌تر را فراهم می‌کند.

این کتابخانه به ویژه برای ساخت نمودارها و گراف‌های سفارشی و تعاملی (مانند نمودارهای میله‌ای، نمودارهای خطی و نمودارهای پراکندگی) که می‌توانند به صورت پویا بر اساس ورودی کاربر یا تغییر داده‌ها به‌روز شوند، محبوب است.

---

برای شبیه‌سازی یک شبکه برق نیروگاه ساده با D3.js، از جمله ولتاژ خط و وضعیت سوئیچ (باز/بسته)، می‌توانیم از D3.js برای تجسم شبکه استفاده کنیم، جایی که گره‌ها نشان‌دهنده نیروگاه‌ها و خطوط شبکه هستند و لبه‌های بین گره‌ها نشان‌دهنده خطوط انتقال هستند. ولتاژ خط را می‌توان با ضخامت یا رنگ لبه‌ها نشان داد و وضعیت سوئیچ (باز/بسته) را می‌توان با استفاده از برچسب‌ها یا آیکون‌ها نشان داد.

در زیر یک مثال اساسی از نحوه تنظیم چنین تجسمی با استفاده از D3.js آورده شده است:

### مثال HTML + D3.js

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>شبیه‌سازی شبکه برق</title>
  <script src="https://d3js.org/d3.v7.min.js"></script>
  <style>
    .node {
      fill: steelblue;
      stroke: #fff;
      stroke-width: 1.5px;
    }

    .link {
      stroke: #999;
      stroke-width: 2px;
    }

    .open {
      stroke: red;
      stroke-width: 3px;
    }

    .close {
      stroke: green;
      stroke-width: 3px;
    }

    .label {
      font-size: 12px;
      font-family: Arial, sans-serif;
      fill: black;
      pointer-events: none;
    }

    .voltage-label {
      font-size: 10px;
      fill: gray;
    }
  </style>
</head>
<body>

<svg width="800" height="600"></svg>

<script>
  // تعریف داده‌ها برای شبکه
  const nodes = [
    { id: 1, name: "نیروگاه A", voltage: 220, x: 100, y: 100 },
    { id: 2, name: "نیروگاه B", voltage: 210, x: 400, y: 150 },
    { id: 3, name: "نیروگاه C", voltage: 230, x: 250, y: 400 }
  ];

  const links = [
    { source: 1, target: 2, status: "close" },
    { source: 2, target: 3, status: "open" },
    { source: 3, target: 1, status: "close" }
  ];

  // تنظیم کانتینر SVG
  const svg = d3.select("svg");

  // ایجاد شبیه‌سازی برای شبکه برق
  const simulation = d3.forceSimulation(nodes)
    .force("link", d3.forceLink(links).id(d => d.id).distance(200))
    .force("charge", d3.forceManyBody().strength(-1000))
    .force("center", d3.forceCenter(400, 300));

  // افزودن لینک‌ها (خطوط شبکه)
  const link = svg.selectAll(".link")
    .data(links)
    .enter().append("line")
    .attr("class", d => "link " + (d.status === "open" ? "open" : "close"))
    .style("stroke-width", 2);

  // افزودن گره‌ها (نیروگاه‌ها)
  const node = svg.selectAll(".node")
    .data(nodes)
    .enter().append("circle")
    .attr("class", "node")
    .attr("r", 20);

  // افزودن برچسب‌ها برای گره‌ها
  svg.selectAll(".label")
    .data(nodes)
    .enter().append("text")
    .attr("class", "label")
    .attr("x", d => d.x)
    .attr("y", d => d.y - 25)
    .text(d => d.name);

  // افزودن برچسب‌های ولتاژ
  svg.selectAll(".voltage-label")
    .data(nodes)
    .enter().append("text")
    .attr("class", "voltage-label")
    .attr("x", d => d.x)
    .attr("y", d => d.y + 25)
    .text(d => `Voltage: ${d.voltage}V`);

  // به‌روزرسانی موقعیت‌ها بر اساس شبیه‌سازی
  simulation.on("tick", () => {
    link
      .attr("x1", d => d.source.x)
      .attr("y1", d => d.source.y)
      .attr("x2", d => d.target.x)
      .attr("y2", d => d.target.y);

    node
      .attr("cx", d => d.x)
      .attr("cy", d => d.y);

    svg.selectAll(".label")
      .attr("x", d => d.x)
      .attr("y", d => d.y - 25);

    svg.selectAll(".voltage-label")
      .attr("x", d => d.x)
      .attr("y", d => d.y + 25);
  });
</script>

</body>
</html>
```

![تصویر نتیجه یک شبکه ساده](/resources/D3JS/images/sample-3.png)

### تجزیه و تحلیل:

1. **گره‌ها**: نشان دهنده نیروگاه‌ها هستند. هر گره دارای `id`، `name`، `voltage` و `position` (`x`، `y`) است.
2. **لینک‌ها**: نشان دهنده خطوط انتقال برق بین نیروگاه‌ها هستند. هر لینک دارای `source`، `target` و `status` (یا `open` یا `close`) است.
3. **شبیه‌سازی D3**: یک طرح‌بندی نیرومند برای شبیه‌سازی رفتار شبکه استفاده می‌شود، جایی که گره‌ها جذب یا دفع می‌شوند و لینک‌ها (خطوط) بین آنها ایجاد می‌شوند.
4. **ولتاژ خط**: ولتاژ در نزدیکی هر گره (نیروگاه) نمایش داده می‌شود و رنگ یا ضخامت لبه‌ها می‌تواند برای نشان دادن وضعیت شبکه برق تنظیم شود.
5. **وضعیت سوئیچ**: خطوط انتقال رنگ‌های متفاوتی دارند (`قرمز` برای باز و `سبز` برای بسته`) برای نشان دادن وضعیت سوئیچ شبکه برق.

### سفارشی‌سازی‌ها:
- می‌توانید مقادیر ولتاژ را به صورت پویا تغییر دهید یا آنها را بر اساس شرایط مختلف تنظیم کنید.
- وضعیت سوئیچ (باز/بسته) با تغییر رنگ خطوط متصل کننده گره‌ها منعکس می‌شود.

این تجسم یک نمای کلی از سیستم شبکه نیروگاهی را ارائه می‌دهد، نشان می‌دهد که گره‌ها چگونه به هم متصل شده‌اند، سطوح ولتاژ آنها و وضعیت خطوط انتقال.

----
برای رفع مشکل و گنجاندن یک نقشه خارجی مانند Leaflet، همراه با افزودن یک پاپ‌آپ به گره‌ها، چندین تنظیمات انجام می‌دهم:

1. **استفاده از Leaflet برای نقشه**: ما طرح‌ریزی `d3.geoMercator` را با عملکرد نقشه Leaflet جایگزین خواهیم کرد.
2. **عملکرد پاپ‌آپ**: یک رویداد کلیک به گره‌ها اضافه می‌کنم که هنگام کلیک جزئیات را نشان می‌دهد.
3. **ادغام نقشه با D3 برای ترسیم گره‌ها و لینک‌ها**: عناصر D3 (مانند گره‌ها و لینک‌ها) را در بالای نقشه Leaflet لایه می‌کنیم.

در اینجا کد به‌روزرسانی شده آورده شده است:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>شبیه‌سازی شبکه برق بر روی نقشه</title>
  <script src="https://d3js.org/d3.v7.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/topojson-client@3.1.0/dist/topojson-client.min.js"></script>
  <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
  <style>
    body { margin: 0; }
    .map { width: 100%; height: 100vh; position: absolute; top: 0; left: 0; }
    .node {
      fill: steelblue;
      stroke: white;
      stroke-width: 1.5px;
    }
    .link {
      stroke: #999;
      stroke-width: 2px;
    }
    .open {
      stroke: red;
      stroke-width: 3px;
    }
    .close {
      stroke: green;
      stroke-width: 3px;
    }
    .label {
      font-size: 12px;
      font-family: Arial, sans-serif;
      fill: black;
    }
    .voltage-label {
      font-size: 10px;
      fill: gray;
    }
  </style>
</head>
<body>

<div id="map" class="map"></div>

<script>
  // تعریف داده‌های نیروگاه‌ها و خطوط انتقال
  const nodes = [
    { id: 1, name: "نیروگاه A", voltage: 220, coordinates: [-122.4194, 37.7749] }, // سان فرانسیسکو
    { id: 2, name: "نیروگاه B", voltage: 210, coordinates: [-118.2437, 34.0522] }, // لس آنجلس
    { id: 3, name: "نیروگاه C", voltage: 230, coordinates: [-73.9352, 40.7306] }  // نیویورک
  ];

  const links = [
    { source: 1, target: 2, status: "close" },
    { source: 2, target: 3, status: "open" },
    { source: 3, target: 1, status: "close" }
  ];

  // инициализация Leaflet карта
  const map = L.map('map').setView([37.7749, -122.4194], 5); // پیش فرض به سان فرانسیسکو

  // добавить слой плитки из OpenStreetMap
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(map);

  // создание ссылок (линий передачи) с использованием D3
  const svg = d3.select(map.getPanes().overlayPane).append('svg')
    .attr("width", map.getSize().x)
    .attr("height", map.getSize().y);

  const g = svg.append("g").attr("class", "leaflet-zoom-hide");

  // Функция для проецирования географических координат в экранные координаты
  function latLonToPixel(lat, lon) {
    return map.latLngToLayerPoint([lat, lon]);
  }

  // Create links (transmission lines)
  const link = g.selectAll(".link")
    .data(links)
    .enter().append("line")
    .attr("class", d => "link " + (d.status === "open" ? "open" : "close"))
    .style("stroke-width", 2)
    .attr("x1", d => latLonToPixel(nodes[d.source - 1].coordinates[1], nodes[d.source - 1].coordinates[0]).x)
    .attr("y1", d => latLonToPixel(nodes[d.source - 1].coordinates[1], nodes[d.source - 1].coordinates[0]).y)
    .attr("x2", d => latLonToPixel(nodes[d.target - 1].coordinates[1], nodes[d.target - 1].coordinates[0]).x)
    .attr("y2", d => latLonToPixel(nodes[d.target - 1].coordinates[1], nodes[d.target - 1].coordinates[0]).y);

  // Создание узлов (электростанции)
  const node = g.selectAll(".node")
    .data(nodes)
    .enter().append("circle")
    .attr("class", "node")
    .attr("r", 6)
    .attr("cx", d => latLonToPixel(d.coordinates[1], d.coordinates[0]).x)
    .attr("cy", d => latLonToPixel(d.coordinates[1], d.coordinates[0]).y)
    .on("click", function (event, d) {
      // Показать всплывающее окно при нажатии на узел
      const popupContent = `
        <strong>${d.name}</strong><br>
        Voltage: ${d.voltage}V`;
      L.popup()
        .setLatLng([d.coordinates[0], d.coordinates[1]])
        .setContent(popupContent)
        .openOn(map);
    });

  // добавление подписей для узлов
  g.selectAll(".label")
    .data(nodes)
    .enter().append("text")
    .attr("class", "label")
    .attr("x", d => latLonToPixel(d.coordinates[1], d.coordinates[0]).x)
    .attr("y", d => latLonToPixel(d.coordinates[1], d.coordinates[0]).y - 10)
    .text(d => d.name);

  // добавление меток напряжения
  g.selectAll(".voltage-label")
    .data(nodes)
    .enter().append("text")
    .attr("class", "voltage-label")
    .attr("x", d => latLonToPixel(d.coordinates[1], d.coordinates[0]).x)
    .attr("y", d => latLonToPixel(d.coordinates[1], d.coordinates[0]).y + 15)
    .text(d => `${d.voltage}V`);

  // Управление масштабированием и перемещением карты
  map.on("zoomend", updatePositions);
  map.on("moveend", updatePositions);

  function updatePositions() {
    // Обновление позиций ссылок и узлов при изменении масштаба или перемещения
    link
      .attr("x1", d => latLonToPixel(nodes[d.source - 1].coordinates[1], nodes[d.source - 1].coordinates[0]).x)
      .attr("y1", d => latLonToPixel(nodes[d.source - 1].coordinates[1], nodes[d.source - 1].coordinates[0]).y)
      .attr("x2", d => latLonToPixel(nodes[d.target - 1].coordinates[1], nodes[d.target - 1].coordinates[0]).x)
      .attr("y2", d => latLonToPixel(nodes[d.target - 1].coordinates[1], nodes[d.target - 1].coordinates[0]).y);

    node
      .attr("cx", d => latLonToPixel(d.coordinates[1], d.coordinates[0]).x)
      .attr("cy", d => latLonToPixel(d.coordinates[1], d.coordinates[0]).y);

    g.selectAll(".label")
      .attr("x", d => latLonToPixel(d.coordinates[1], d.coordinates[0]).x)
      .attr("y", d => latLonToPixel(d.coordinates[1], d.coordinates[0]).y - 10);

    g.selectAll(".voltage-label")
      .attr("x", d => latLonToPixel(d.coordinates[1], d.coordinates[0]).x)
      .attr("y", d => latLonToPixel(d.coordinates[1], d.coordinates[0]).y + 15);
  }

</script>

</body>
</html>
```
![تصویر نتیجه یک شبکه ساده](/resources/D3JS/images/sampl-4.png)

### توضیح تغییرات:
1. **ادغام Leaflet**: جاوا اسکریپت و CSS Leaflet را برای رندر کردن نقشه گنجانده‌ام و یک لایه کاشی OpenStreetMap اضافه کرده‌ام.
2. **عملکرد نقشه و بزرگنمایی**: از `map.latLngToLayerPoint()` Leaflet برای تبدیل مختصات جغرافیایی به مختصات پیکسلی استفاده می‌کنیم و گره‌ها و لینک‌ها را به درستی روی نقشه قرار می‌دهیم.
3. **عملکرد بازشو**: هنگام کلیک بر روی یک گره، یک پنجره بازشو ظاهر می‌شود و نام و ولتاژ نیروگاه را نشان می‌دهد.
4. **موقعیت‌یابی لینک**: خطوط انتقال (لینک‌ها) با استفاده از عناصر `line` از D3 کشیده می‌شوند و موقعیت‌های آنها بر اساس بزرگنمایی و حرکت فعلی نقشه به‌روزرسانی می‌شوند.

اکنون باید نقشه‌ای نمایش داده شود، نیروگاه‌ها به عنوان گره‌های قابل کلیک رندر شوند و خطوط انتقال بین آنها نشان داده شوند و با کلیک بر روی یک گره، جزئیات ظاهر شوند.

---