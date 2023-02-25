"""empty message

Revision ID: dfea2ae0354d
Revises: 531a44fde528
Create Date: 2023-02-23 23:55:05.705472

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'dfea2ae0354d'
down_revision = '531a44fde528'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('booking_data', schema=None) as batch_op:
        batch_op.add_column(sa.Column('arrival_date', sa.String(length=20), nullable=True))
        batch_op.add_column(sa.Column('occupant_postal_code', sa.String(length=50), nullable=True))
        batch_op.drop_column('arrival_year')
        batch_op.drop_column('occupant_postal_codee')

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('booking_data', schema=None) as batch_op:
        batch_op.add_column(sa.Column('occupant_postal_codee', sa.VARCHAR(length=50), nullable=True))
        batch_op.add_column(sa.Column('arrival_year', sa.VARCHAR(length=5), nullable=True))
        batch_op.drop_column('occupant_postal_code')
        batch_op.drop_column('arrival_date')

    # ### end Alembic commands ###