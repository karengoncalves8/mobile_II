import cors from 'cors';
import express from 'express';
import { createDatabase } from './db.js';
import { ProductRepository } from './repositories/productRepository.js';
import { ProductService } from './services/productService.js';
import { ProductController } from './controllers/productController.js';
import { createProductRoutes } from './routes/productRoutes.js';

export async function createApp() {
  const db = await createDatabase();

  const productRepository = new ProductRepository(db);
  const productService = new ProductService(productRepository);
  const productController = new ProductController(productService);

  const app = express();

  app.use(cors());
  app.use(express.json());

  app.get('/health', (_req, res) => {
    res.json({ status: 'ok' });
  });

  app.use('/api', createProductRoutes(productController));

  app.use((error, _req, res, _next) => {
    if (error instanceof SyntaxError) {
      res.status(400).json({ message: 'Invalid JSON payload.' });
      return;
    }

    if (error instanceof Error) {
      res.status(400).json({ message: error.message });
      return;
    }

    res.status(500).json({ message: 'Unexpected server error.' });
  });

  return app;
}
