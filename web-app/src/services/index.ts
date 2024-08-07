import { DefaultApiFactory } from '#/index';
import axios from 'axios';

export const ApiService = DefaultApiFactory(undefined, import.meta.env.VITE_EDGE_FUNCTIONS_BASE_URL, axios)