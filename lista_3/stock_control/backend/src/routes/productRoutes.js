import { Router } from 'express';

export function createProductRoutes(controller) {
  const router = Router();

  router.get('/products', controller.list);
  router.post('/products', controller.create);
  router.put('/products/:id', controller.update);
  router.patch('/products/:id/amount', controller.updateAmount);
  router.delete('/products/:id', controller.remove);

  return router;
}
