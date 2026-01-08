import { useBackend } from '../../backend';
import {
  Button,
  LabeledList,
  Section,
  Table,
  ProgressBar,
  NumberInput,
  Stack,
  Box,
} from '../../components';
import { Window } from '../../layouts';

// =================== ТИПЫ ДАННЫХ ===================

interface FuelEntry {
  name: string;
  amount: number;
}

interface CoreData {
  id: string;
  ref: string;
  active: boolean;
  field_strength: number;
  size: number;
  instability: number;
  temperature: number;
  power_usage: number;
  power_available: number;
  fuel: FuelEntry[];
}

interface Data {
  cores: CoreData[];
}

// =================== ОСНОВНОЙ КОМПОНЕНТ ===================

export const FusionCoreControl = (props: any, context: any) => {
  const { act, data } = useBackend<Data>(context);
  const { cores = [] } = data;

  return (
    <Window width={800} height={600} theme="ntos">
      <Window.Content scrollable>
        <Section title="Контроль термоядерных ядер R-UST Mk.8">
          {cores.length === 0 ? (
            <Box>В локальной сети не обнаружено активных ядер.</Box>
          ) : (
            <Stack vertical fill>
              {cores.map((core: CoreData) => (
                <CoreControlPanel key={core.ref} core={core} act={act} />
              ))}
            </Stack>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};

// =================== КОМПОНЕНТ ПАНЕЛИ УПРАВЛЕНИЯ ЯДРОМ ===================

const CoreControlPanel = (props: any, context: any) => {
  const { core, act } = props;

  return (
    <Section title={`Ядро ${core.id}`} level={2}>
      <LabeledList>
        {/* Статус и управление активностью */}
        <LabeledList.Item label="Состояние">
          <Button
            icon="power-off"
            color={core.active ? 'green' : 'red'}
            onClick={() => act('toggle_active', { machine: core.ref })}
          >
            {core.active ? 'АКТИВНО' : 'ОСТАНОВЛЕНО'}
          </Button>
        </LabeledList.Item>

        {/* Мощность поля */}
        <LabeledList.Item label="Мощность поля">
          <Box inline>{core.field_strength / 10} Тл</Box>
        </LabeledList.Item>

        {/* Размер поля */}
        <LabeledList.Item label="Размер поля">
          {core.active ? (
            <Box inline>{core.size} метр(ов)</Box>
          ) : (
            <Box inline color="gray">
              Поле отключено
            </Box>
          )}
        </LabeledList.Item>

        {/* Нестабильность */}
        <LabeledList.Item label="Нестабильность">
          {core.active ? (
            <ProgressBar
              value={core.instability}
              minValue={0}
              maxValue={100}
              ranges={{
                good: [0, 50],
                average: [50, 80],
                bad: [80, 100],
              }}
            >
              {core.instability.toFixed(1)}%
            </ProgressBar>
          ) : (
            <Box inline color="gray">
              Поле отключено
            </Box>
          )}
        </LabeledList.Item>

        {/* Температура плазмы */}
        <LabeledList.Item label="Температура плазмы">
          {core.active ? (
            <Box inline>{core.temperature.toFixed(1)} K</Box>
          ) : (
            <Box inline color="gray">
              Поле отключено
            </Box>
          )}
        </LabeledList.Item>

        {/* Энергопотребление */}
        <LabeledList.Item label="Энергопотребление">
          <ProgressBar
            value={core.power_available}
            minValue={0}
            maxValue={Math.max(core.power_usage, 1)}
            ranges={{
              good: [core.power_usage * 0.9, core.power_usage],
              average: [core.power_usage * 0.5, core.power_usage * 0.9],
              bad: [0, core.power_usage * 0.5],
            }}
          >
            {core.power_available} / {core.power_usage} Вт
          </ProgressBar>
        </LabeledList.Item>

        {/* Управление мощностью */}
        <LabeledList.Item label="Регулировка мощности">
          <Stack align="center">
            <Stack.Item>
              <NumberInput
                value={core.field_strength}
                minValue={0}
                maxValue={1000}
                step={10}
                stepPixelSize={10}
                width="80px"
                onChange={(value: number) =>
                  act('set_strength', {
                    machine: core.ref,
                    value: value - core.field_strength,
                  })
                }
              />
            </Stack.Item>
            <Stack.Item>
              <Stack>
                <Button
                  icon="plus"
                  tooltip="Увеличить на 10"
                  onClick={() =>
                    act('set_strength', {
                      machine: core.ref,
                      value: 10,
                    })
                  }
                />
                <Button
                  icon="minus"
                  tooltip="Уменьшить на 10"
                  onClick={() =>
                    act('set_strength', {
                      machine: core.ref,
                      value: -10,
                    })
                  }
                />
                <Button
                  icon="pen"
                  tooltip="Ручной ввод"
                  onClick={() =>
                    act('set_strength', {
                      machine: core.ref,
                      value: 0,
                    })
                  }
                />
              </Stack>
            </Stack.Item>
          </Stack>
        </LabeledList.Item>

        {/* Топливо */}
        <LabeledList.Item label="Топливо" verticalAlign="top">
          {!core.active || !core.fuel || core.fuel.length === 0 ? (
            <Box color="gray">Отсутствует</Box>
          ) : (
            <Table>
              <Table.Row header>
                <Table.Cell>Реагент</Table.Cell>
                <Table.Cell>Количество</Table.Cell>
              </Table.Row>
              {core.fuel.map((fuel: FuelEntry) => (
                <Table.Row key={fuel.name}>
                  <Table.Cell>{fuel.name}</Table.Cell>
                  <Table.Cell>{fuel.amount.toFixed(2)}</Table.Cell>
                </Table.Row>
              ))}
            </Table>
          )}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
