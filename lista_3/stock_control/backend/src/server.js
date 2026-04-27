import { createApp } from './app.js';

const port = Number(process.env.PORT ?? 3000);

const app = await createApp();

app.listen(port, () => {
  console.log(`Stock Control API listening on http://localhost:${port}`);
});
