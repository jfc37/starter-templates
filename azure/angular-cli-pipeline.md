# Setting up a new pipeline for an angular cli project

## Full credit to
https://dev.to/thisdotmedia/continuously-integrating-angular-with-azure-devops-2k9l

## Project setup

### Scripts to run
```npm install puppeteer --save-dev```

### karma.config.js
At the top:
```
const process = require('process');

process.env.CHROME_BIN = require('puppeteer').executablePath();
```

```browsers: ['ChromeHeadless']```

```
junitReporter: {
  outputDir: 'reports', // results will be saved as $outputDir/$browserName.xml
},
```

```
coverageIstanbulReporter: {
   dir: require('path').join(__dirname, './reports/coverage'),
   reports: ['html', 'lcovonly', 'text-summary', 'cobertura'],
  fixWebpackSourcePaths: true
},
```

### assets/config.json

### config.service.ts
```
@Injectable({
  providedIn: 'root',
})
export class ConfigService {
  config: Config;

  constructor(private http: HttpClient) {}

  async loadConfig() {
    const config = await this.http
      .get<Config>('./assets/config.json')
      .toPromise();
    this.config = config;
  }
}
```

### app.module.ts
```
export const configFactory = (configService: ConfigService) => {
  return () => configService.loadConfig();
};
...
providers: [
  {
    provide: APP_INITIALIZER,
    useFactory: configFactory,
    deps: [ConfigService],
    multi: true,
  },
],
```
